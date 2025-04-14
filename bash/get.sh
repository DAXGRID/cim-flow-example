#!/usr/bin/env bash

set -e

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <Url> <OutPutPath> <Username> <Password>" >&2
    echo "Error: Incorrect number of arguments provided." >&2
    exit 1
fi

url="$1"
output="$2"
username="$3"
password="$4"

echo "Downloading file in path '$url'."
http_status=$(curl -sS --write-out '%{http_code}' -X GET -o "$output" -u "$username:$password" "$url")
curl_exit_status=$?

if [ "$curl_exit_status" -ne 0 ]; then
    echo "Error: curl command failed with exit status $curl_exit_status. Could not complete request to '$url'." >&2
    exit 1
fi

if [[ "$http_status" -ge 200 && "$http_status" -lt 300 ]]; then
    echo "Finished dowloading the file to the path '$output'. Status Code: $http_status."
    exit 0 # Success
else
    echo "Error: Failed to download the file. Server responded with HTTP Status Code: $http_status" >&2
    exit 1 # Failure
fi
