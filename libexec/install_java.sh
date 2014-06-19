#!/bin/bash
if [[ -x $(which java) ]]; then
  echo "Java already installed."
elif [[ -x $(which apt-get) ]]; then
  UPDATE_SUCCEEDED=0
  for ((i = 1; i <= 3; i++)); do
    if apt-get -y -qq update; then
      UPDATE_SUCCEEDED=1
      break
    else
      echo "apt-get update attempt $i failed! Trying again..." >2
    fi
  done

  if ! (( ${UPDATE_SUCCEEDED} )); then
    echo "Final attempt to apt-get update..."
    # Let any final error propagate all the way out to any error traps.
    apt-get -y -qq update
  fi

  apt-get -y -qq install openjdk-7-jre-headless
elif [[ -x $(which yum) ]]; then
  yum -y -q install java-1.7.0-openjdk
else
  echo 'Cannot find package manager to install java. Exiting' >2
  exit 1
fi
