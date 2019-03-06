#!/bin/bash

function print_usage {
  echo "Usage:"
  echo
  echo "  $0 photo_dir output_dir"
  echo "    this will extract faces in directory"
  echo ""
  echo "    photo_dir:     the source photo directory"
  echo "    output_dir:    the directory which stores extrated faces"
  echo

  exit
}

if [ $# -lt 2 ]; then
     print_usage
fi

photo_dir=${1}
output_dir=${2}

python3 faceswap.py extract -i $1 -o $2