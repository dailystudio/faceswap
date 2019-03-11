#!/bin/bash

function print_usage {
  echo "Usage:"
  echo
  echo "  $0 keywords engine output_dir"
  echo "    this will extract faces in directory"
  echo ""
  echo "    keywords:       the keywords of images"
  echo "    engine:         the engine of crawler, include google, bing, yahoo, baidu, sogou, 360"
  echo "    num_of_images:  the target amount of images"
  echo "    output_dir:     the directory which stores crawled images"
  echo

  exit
}

if [ $# -lt 2 ]; then
     print_usage
fi

keywords=${1}
engine=${2}
num_of_images=${3}
output_dir=${4}

tmp_dir=./crawled
source_dir=./crawled/${keyword}

mkdir -p $tmp_dir

echo "crawling ${num_of_images} images for ${keywords} with ${engine} to temporary directory: [${tmp_dir}]"

pisces -e $engine -w 4 -n ${num_of_images} ${keywords} -o ${tmp_dir}
echo "moving images to target directory: [${output_dir}]"

mv ${source_dir}/* ${output_dir}/

rm -rf ${tmp_dir}