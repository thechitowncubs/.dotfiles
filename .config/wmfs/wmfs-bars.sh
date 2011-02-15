#!/bin/bash
while [ "$(pidof wmfs)" ]
do
  conky | while read -r; do wmfs -s -name "\\#8BD640\\$REPLY \\#D3D7CF\\$(date +%r,\ %A\ %x)"; done
  sleep 1 
done
