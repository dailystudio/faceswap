#!/bin/bash

function print_usage {
  echo "Usage:"
  echo
  echo "  $0 person videos_list_file proxy"
  echo "    this will prepare faces data for the person from videos automatically"
  echo ""
  echo "    person:		        person name"
  echo "    videos_list_file:	a videos list file with information pair [person, youtube video id] in each line."
  echo "    proxy:		        proxy if it is required"
  echo

  exit
}

if [ $# -lt 2 ]; then
     print_usage
fi

frames_dir="frames"
data_dir="data"
videos_dir="videos"

person=${1}
videos_list_file=${2}
proxy=${3}

source_dir=${videos_dir}/${person}

echo "Preparing data for person: [${person}], video list = [${videos_list_file}]"
./download_youtube_video.sh ${videos_list_file} ${source_dir} ${proxy}

tmpfile="prepare.list"

ls -1 ${source_dir}/* > ${tmpfile}
cat ${tmpfile} | while read i; do
	bname=`basename ${i}`
	dumped_dir=${frames_dir}/${bname%.*}
	faces_dir=${data_dir}/${person}
	echo "Dumpping frames from video [${i}] to [${dumped_dir}]"
	./dump_frames.sh ${i} ${frames_dir}

	echo "Extrating faces from frames in [${dumped_dir}] to [${faces_dir}]" 
	./extract_faces.sh ${dumped_dir} ${faces_dir}
done

rm ${tmpfile}
