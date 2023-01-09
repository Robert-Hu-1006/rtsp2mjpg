#!/bin/bash

RTSP_URL="rtsp://172.16.1.30/gama.avi"
FFSERVER_LOG_LEVEL="error"
FFMPEG_LOG_LEVEL="warning"
FFMPEG_INPUT_OPTS="-use_wallclock_as_timestamps 1"
FFMPEG_OUTPUT_OPTS="-async 1 -vsync 1"
FFMPEG_SCALE="384:216"

trap "exit" INT TERM ERR
trap "kill 0" EXIT

echo "url:" ${RTSP_URL}

ffserver -hide_banner -loglevel ${FFSERVER_LOG_LEVEL} &
echo "rtsp:" ${RTSP_URL}
ffmpeg -hide_banner -loglevel ${FFMPEG_LOG_LEVEL} -rtsp_transport tcp ${FFMPEG_INPUT_OPTS} -vf scale=${FFMPEG_SCALE} -i ${RTSP_URL} ${FFMPEG_OUTPUT_OPTS} http://127.0.0.1:8090/feed.ffm