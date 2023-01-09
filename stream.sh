#!/bin/sh

F1_URL="rtsp://172.16.1.30/cut.avi"
F2_URL="rtsp://172.16.1.30/gama.avi"

FFSERVER_LOG_LEVEL="error"
FFMPEG_LOG_LEVEL="warning"
FFMPEG_INPUT_OPTS="-use_wallclock_as_timestamps 1"
FFMPEG_OUTPUT_OPTS="-async 1 -vsync 1"
FFMPEG_SCALE="iw*.25:ih*.25"

#trap "exit" INT TERM ERR
#trap "kill 0" EXIT
echo "stream 1:" ${F1_URL}
ffserver -hide_banner -loglevel ${FFSERVER_LOG_LEVEL} &
ffmpeg -hide_banner -loglevel ${FFMPEG_LOG_LEVEL} -rtsp_transport tcp ${FFMPEG_INPUT_OPTS} -i ${F1_URL} -vf scale=${FFMPEG_SCALE} ${FFMPEG_OUTPUT_OPTS} http://127.0.0.1:8090/f1.ffm &
ffmpeg -hide_banner -loglevel ${FFMPEG_LOG_LEVEL} -rtsp_transport tcp ${FFMPEG_INPUT_OPTS} -i ${F2_URL} -vf scale=${FFMPEG_SCALE} ${FFMPEG_OUTPUT_OPTS} http://127.0.0.1:8090/f2.ffm 
echo "stream 1:" ${F1_URL}