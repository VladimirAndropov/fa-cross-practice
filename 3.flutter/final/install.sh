#!/usr/bin/env bash

cd "$(dirname "$(readlink -f "$0")")"

# Available versions
# 2.5, 2.4.1

TF_VERSION=2.5
URL="https://github.com/am15h/tflite_flutter_plugin/releases/download/"
TAG="tf_$TF_VERSION"

ANDROID_DIR="android/app/src/main/jniLibs/"
ANDROID_LIB="libtensorflowlite_c.so"

ARM_DELEGATE="libtensorflowlite_c_arm_delegate.so"
ARM_64_DELEGATE="libtensorflowlite_c_arm64_delegate.so"
ARM="libtensorflowlite_c_arm.so"
ARM_64="libtensorflowlite_c_arm64.so"
X86="libtensorflowlite_c_x86_delegate.so"
X86_64="libtensorflowlite_c_x86_64_delegate.so"

delegate=0

while getopts "d" OPTION
do
	case $OPTION in
		d)  delegate=1;;
	esac
done


download () {
    # wget "${URL}${TAG}/$1" -O "$1"
    
    #
    FILE=$1 
    PLATFORM=$2
    DOWNLOAD_URL="${URL}${TAG}/${FILE}"

    # echo "${URL}${TAG}/$1"
    # echo "ANDROID_DIR: ${ANDROID_DIR}"
    # echo "1: $1  2: $2"
    echo "DOWNLOAD_URL: ${DOWNLOAD_URL}"
    echo "FILE: ${FILE}"
    echo "DIR: ${ANDROID_DIR}${PLATFORM}"
    # echo "ANDROID_LIB: ${ANDROID_LIB}"
    
    curl -o "$FILE" -L "${DOWNLOAD_URL}" 
    mkdir -p "${ANDROID_DIR}${PLATFORM}/"
    # echo "$1 -> ${ANDROID_DIR}$PLATFORM/${ANDROID_LIB}"
    mv $FILE "${ANDROID_DIR}${PLATFORM}/${ANDROID_LIB}"
    echo ""
}
echo "delegate: $delegate"
if [ ${delegate} -eq 1 ]
then

download ${ARM_DELEGATE} "armeabi-v7a"
download ${ARM_64_DELEGATE} "arm64-v8a"

else

download ${ARM} "armeabi-v7a"
download ${ARM_64} "arm64-v8a"

fi

download ${X86} "x86"
download ${X86_64} "x86_64"
