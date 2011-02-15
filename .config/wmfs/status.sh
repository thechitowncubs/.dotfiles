#!/bin/bash
do
  conky | while read -r; do wmfs -s -name "$REPLY \\#FFFFFF\| \\#D4D4D4\\$(date +%r,\ %A\ %x)"; done
done
