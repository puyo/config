#!/bin/sh

set -xeuo pipefail

sudo apt install libidn12:i386 patchelf

patchelf --replace-needed libidn.so.11 libidn.so.12 bin/SLVoice lib32/libortp.so lib32/libvivoxplatform.so lib32/libvivoxsdk.so
