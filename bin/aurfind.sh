#!/bin/bash

#
# stupid proof of concept bash based AUR agent
#

shopt -s extglob

declare -l header             # response headers aren't always Mixed-Case
declare content_encoding=cat  # default NOOP decompressor

uastring="bashium 0.2 (bash ${BASH_VERSINFO[0]}-${BASH_VERSINFO[1]})"

fmt_pkgpath='/packages/%s/%s.tar.gz'
fmt_rpcpath='/rpc.php?type=%s&arg=%s'

usage() {
  printf -- 'Usage: %s operation targets...\n\n' "${0##*/}"
  printf -- 'Operations:\n'
  printf -- '\t-d    download\n'
  printf -- '\t-i    package info\n'
  printf -- '\t-m    search by maintainer\n'
  printf -- '\t-s    search by package\n\n'
  exit 1
}

# content handlers
json() {
  type -P json_reformat >/dev/null && json_reformat || cat
}

x-tgz() {
  tar xz
  if (( $? )); then 
    echo "error downloading $target"
  else
    echo "$target downloaded to $PWD"
  fi
}


# decompress handlers
gzip() {
  command gzip -cd
}

deflate() {
  uncompress -c
}


# connect handler
connect() {
  { exec 4<>/dev/tcp/aur.archlinux.org/80; } 2>/dev/null
  (( $? )) && { echo "error: failed to connect to AUR"; exit 1; }
}

shutdown() {
  exec 4<&-
}


# request handler
send_http_request() {
  printf 'GET %s HTTP/1.1\r
User-Agent: %s\r
Host: aur.archlinux.org\r
Accept-Encoding: gzip,deflate\r
Accept: */*\r
Connection: Keep-Alive\r
\r
' "$1" "$uastring" >&4
}


# response handlers
read_response_code() {
  read -r -u 4 _ resp _
  if [[ $resp ]]; then
    if (( resp == 404 )); then
      echo "error: package $arg not found"
      exit 1
    elif (( resp >= 300 )); then
      echo "error: server responded with HTTP $resp"
      exit 1
    fi
    # assume HTTP 200 (eww)
  fi
}

read_response_headers() {
  # read response until the end of the headers
  while IFS=': ' read -r -u 4 header value; do
    # end of headers
    [[ $header = $'\r' ]] && break

    read -r -d $'\r' "${header//-/_}" <<< "$value"
  done

  content_type=${content_type##*/} # trim 'application/'

  if [[ $(type -t $content_type) != @(function|file) ]]; then
    echo "error: unknown/unhandled content type: $content_type"
    exit 1
  fi

  if [[ $(type -t $content_encoding) != @(function|file) ]]; then
    echo "error: unknown/unhandled encoding type: $content_encoding"
    exit 1
  fi
}

read_response_body() {
  if (( content_length )); then
    <&4 dd bs=$content_length count=1 2>/dev/null | $content_encoding | $content_type
  elif [[ "$transfer_encoding" = chunked ]]; then
    while true; do
      read -r -d $'\r\n' -u 4 len           # read length, consume cr

      len=$(( 0x$len ))                     # convert from hex2dec
      if (( len == 0 )); then
        read -r -n 4 -u 4 _                 # consume crlfcrlf
        break
      fi

      # dd seems to round block sizes, so this sadly has to be unbuffered
      <&4 dd skip=1 bs=1 count=$len 2>/dev/null
      read -r -n 2 -u 4 _                   # consume crlf
    done | $content_encoding | $content_type
  else
    $content_encoding <&4 | $content_type
  fi
}

trap 'shutdown' 0 QUIT TERM INT

# main()
while getopts ':dhims' opt; do
  case $opt in
    d) uri=$fmt_pkgpath; rtype=dl ;;
    h) usage ;;
    i) uri=$fmt_rpcpath; rtype=rpc; qtype=info ;;
    m) uri=$fmt_rpcpath; rtype=rpc; qtype=msearch ;;
    s) uri=$fmt_rpcpath; rtype=rpc; qtype=search ;;
    ?) echo "${0##*/}: invalid option -- '$OPTARG'"
       exit 1 ;;
    *) usage ;;
  esac
done
shift $(( OPTIND - 1 ))

connect
for target; do
  [[ -n qtype ]] && arg=$qtype || arg=$target
  send_http_request "$(printf "$uri" "$arg" "$target")"
  read_response_code
  read_response_headers
  read_response_body
done


