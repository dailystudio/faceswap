#!/bin/bash

function print_usage {
  echo "Usage:"
  echo
  echo "  $0  videos_list_file output_dir proxy"
  echo "    this will extract faces in directory"
  echo ""
  echo "    video_list_file:	videos to be downloaded. A list with video pair: person, video_id"
  echo "    output_dir:    	the directory which stores videos"
  echo "    proxy:		http proxy if it is required"
  echo

  exit
}

if [ $# -lt 2 ]; then
     print_usage
fi

video_list=${1}
output_dir=${2}
proxy=${3}

echo "Downloading yotube videos ... [${output_dir}]"

if [ ! -z "${proxy}" ]; then
	echo "Using proxy: ${proxy}"
	proxy_segment="--proxy ${proxy}"
else
	proxy_segment=""
fi

if [ ! -d ${output_dir}/${person} ]; then
	mkdir -p ${output_dir}/${person}
fi

cat ${video_list} | while read i; do
	person=${i%,*}
	vid=$(echo ${i#*,} | xargs) 

	url="https://www.youtube.com/watch?v=${vid}"
	file="${output_dir}/${person}_%(id)s_%(height)dp.%(ext)s"
	echo
	echo "Processing ${person}'s video: ${url}"

	youtube-dl ${url} -o ${file} ${proxy_segment}
done

