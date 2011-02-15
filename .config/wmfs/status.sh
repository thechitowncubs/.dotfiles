#!/bin/bash
while [ "$(pidof wmfs)" ]
do
  conky | while read -r; do wmfs -s -name "$REPLY \\#FFFFFF\| \\#D4D4D4\\$(date +%r,\ %A\ %x)"; done
  sleep 1 
done
