#!/usr/bin/env bash

set -e

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <Url> <Username> <Password>" >&2
    echo "Error: Incorrect number of arguments provided. It should be <URL> <USERNAME> <PASSWORD>." >&2
    exit 1
fi

url="$1"
username="$2"
password="$3"

echo "Deleting file in path '$url'."
http_status=$(curl -sS -X DELETE -u "${username}:${password}" -w "%{http_code}" -o /dev/null "$url")
curl_exit_status=$?

if [ "$curl_exit_status" -ne 0 ]; then
    echo "Error: curl command failed with exit status $curl_exit_status. Could not complete request to '$url'." >&2
    exit 1
fi

if [[ "$http_status" -ge 200 && "$http_status" -lt 300 ]]; then
    echo "Finished deleting the file. Status Code: $http_status"
    exit 0 # Success
else
    echo "Error: Failed to delete file. Server responded with HTTP Status Code: $http_status" >&2
    exit 1 # Failure
fi
