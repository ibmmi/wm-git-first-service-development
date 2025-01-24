#!/bin/sh

apk -q update
apk -q upgrade
apk add curl

assureDownloadableFile(){
  # params
  # ${1} - Target file directory
  # ${2} - Target file name
  # ${3} - sha256 sum of the file
  # ${4} - origin url
  if [ ! -f "${1}/${2}" ]; then
      echo "File \"${1}/${2}\" not present, downloading now..." 
      
      mkdir -p "${1}" || return 1
      curl -L ${4} -o "${1}/${2}" || return 2
  fi

  echo "Checking sha256sum for file \"${1}/${2}\" ..."

  echo "${3}" "${1}/${2}"  | sha256sum -c
  local res=$?
  if [ ${res} -ne 0 ]; then
    echo "ERROR - checksum for file \"${1}/${2}\" does not match!"
    mv "${1}/${2}" "${1}/${2}.dubious"
  fi
}

### Add here a line for each necessary dependency
assureDownloadableFile \
  "${CODE_MOUNT_POINT}/is-packages/MyPackage/code/jars" \
  "snowflake-id-0.0.2.jar" \
  "B17E4093BD1780C23DE11106FACEF1811313119FA7B1803D90C115C5CCE788D1" \
  "https://repo1.maven.org/maven2/de/mkammerer/snowflake-id/snowflake-id/0.0.2/snowflake-id-0.0.2.jar"
