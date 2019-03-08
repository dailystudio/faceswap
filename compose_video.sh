ffmpeg -i $1/video-frame-%0d.png -c:v libx264 -vf "fps=25,format=yuv420p" $2
