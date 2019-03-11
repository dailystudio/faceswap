#!/bin/bash

function print_usage {
  echo "Usage:"
  echo
  echo "  $0 search_list_file search_engine"
  echo "    this will prepare faces data for the person from search engine automatically"
  echo ""
  echo "    search_list_file:	a videos list file with information pair [person, keyword]"
  echo "    search_engine:	    one of google, bing, yahoo, baidu, sogou, 360"
  echo "    num_of_images:	    images amount for each person"
  echo

  exit
}

if [ $# -lt 3 ]; then
     print_usage
fi

image_dir="images"
data_dir="data"

search_list_file=${1}
search_engine=${2}
num_of_images=${3}

echo "Preparing data for search list [${search_list_file}]"
cat ${search_list_file} | while read i; do
    echo ${i}
	person=${i%,*}
	keyword=$(echo ${i#*,} | xargs)
	dumped_dir=${image_dir}/${person}
    faces_dir=${data_dir}/${person}

	echo "Crawling ${person}'s images with keyword [${keyword}]"
	./crawl_image.sh ${keyword} ${search_engine} ${num_of_images} ${dumped_dir}

	echo "Extrating faces from images in [${dumped_dir}] to [${faces_dir}]"
	./extract_faces.sh ${dumped_dir} ${faces_dir}

done

