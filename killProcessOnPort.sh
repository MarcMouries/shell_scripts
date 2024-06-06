#!/bin/bash

# Check if port number is provided
if [ -z "$1" ]
then
  echo "Usage: $0 <port-number>"
  exit 1
fi

# Find and kill the process using the specified port
kill $(lsof -t -i:$1)
