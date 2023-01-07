#!/usr/bin/env bash

echo "Content-Type: multipart/x-mixed-replace;boundary=ffmpeg"
echo "Cache-Control: no-cache"
echo ""
$SOURCE_URL="rtsp://172.16.1.30/gama.avi"
$SCALE="384:216"
echo "$(date +%s) - Converting ${SOURCE_URL} to MJPG stream with a height of ${JPG_RESOLUTION}" 1>&2
ffmpeg -hide_banner -loglevel error -i "${SOURCE_URL}" -c:v mjpeg -vf "fps=15, scale='$SCALE'" -q:v 1 -f mpjpeg -an -