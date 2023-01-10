#!/bin/bash

echo "This is going to extract speech into a text file from a video"
echo "Enter the name of the video"
read file
ffmpeg -i $file output_audio.wav

arr=($(ffprobe -v error -show_entries stream=sample_rate,channels -of default=noprint_wrappers=1 output_audio.wav | grep -o '[0-9]\+'))
echo "Sample Rate: ${arr[0]}"
echo "Channels: ${arr[1]}"

echo "Enter the name of the in-bucket for google cloud storage. You must use unique bucket names."
read BUCKET_IN_ENV
echo "Enter the name of the out-bucket for google cloud storage"
read BUCKET_OUT_ENV
export BUCKET_IN=$BUCKET_IN_ENV
export BUCKET_OUT=$BUCKET_OUT_ENV
gsutil mb gs://$BUCKET_IN
gsutil mb gs://$BUCKET_OUT
gsutil cp output_audio.wav gs://$BUCKET_IN/
python3 speech2srt.py --storage_uri gs://$BUCKET_IN/output_audio.wav --sample_rate_hertz ${arr[0]} --audio_channel_count ${arr[1]} --out_file transcript
python3 main.py transcript.txt
