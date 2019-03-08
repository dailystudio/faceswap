#!/bin/bash

function print_usage {
  echo "Usage:"
  echo
  echo "  $0 video_file output_dir"
  echo "    this will dump frames from video"
  echo ""
  echo "    video_file:     the source video file"
  echo "    output_dir:     the directory which stores dumpped frames"
  echo

  exit
}

if [ $# -lt 2 ]; then
     print_usage
fi

video_file=${1}
output_dir=${2}

bname=`basename ${video_file}`
video_prefix=${bname%.*}

target_dir=${output_dir}/${video_prefix}

echo "dumpping frames from ${video_file} to directory: [${target_dir}], frames prefix = [${video_prefix}]"

mkdir -p ${target_dir}

ffmpeg -i ${video_file} ${target_dir}/${video_prefix}_video-frame-%d.png < /dev/null
