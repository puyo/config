#!/bin/bash

SINK_NAME=combined-app-sink
VIRTUAL_MIC_NAME=my-virtualmic

results=$(pw-link -o | grep "${1}")
IFS=$'\n' read -ra ADDR -d $'\0' <<< "$results"

# Unload if exists
pactl unload-module module-null-sink

# Make new sinks
pactl load-module module-null-sink media.class=Audio/Sink sink_name=$SINK_NAME channel_map=stereo > /dev/null
pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=$VIRTUAL_MIC_NAME channel_map=front-left,front-right > /dev/null

# Extract app name
IFS=':'
read -ra APP_STR <<< "${ADDR[0]}"

echo "Linking app ${APP_STR[0]} to ${SINK_NAME}"
pw-link "${APP_STR[0]}":output_FL $SINK_NAME:playback_FL
pw-link "${APP_STR[0]}":output_FR $SINK_NAME:playback_FR

echo "Linking $MIC_SOURCE to ${SINK_NAME}"
pw-link "alsa_input.pci-0000_00_1f.3.analog-stereo.30:capture_FL" $SINK_NAME:playback_FL
pw-link "alsa_input.pci-0000_00_1f.3.analog-stereo.30:capture_FR" $SINK_NAME:playback_FR

echo "Creating virtual mic: $VIRTUAL_MIC_NAME"
pw-link $SINK_NAME:monitor_FL $VIRTUAL_MIC_NAME:input_FL
pw-link $SINK_NAME:monitor_FR $VIRTUAL_MIC_NAME:input_FR
