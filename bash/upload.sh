#!/usr/bin/env bash

set -e

if [[ "$#" -lt "4" ]]; then
    echo "Usage: $0 <Url> <Username> <Password> <Files>" >&2
    echo "Error: Incorrect number of arguments provided." >&2
    exit 1
fi

url=$1
username=$2
password=$3
files=${@:4}

echo "Compressing files $files."

zip_name="$(date '+%Y_%m_%d_%H_%M_%S')_cim.zip"

echo "Zipping files '$files' into '$zip_name'."
zip $zip_name $files

echo "Uploading file '$zip_name' to '$url'."

http_status=$(curl -sS -u "$username:$password" \
  -o /dev/null -w "%{http_code}" \
  -i -X POST -H "Content-Type: multipart/form-data" \
  -F "data=@$zip_name" \
  $url)

curl_exit_status=$?

echo "Cleaning up temporary files '$zip_name'."
rm ./$zip_name

if [ "$curl_exit_status" -ne 0 ]; then
    echo "Error: curl command failed with exit status $curl_exit_status. Could not complete request to '$url'." >&2
    exit 1
fi

if [[ "$http_status" -ge 200 && "$http_status" -lt 300 ]]; then
    echo "Finished uploading the file $zip_name to the path '$output'. Status Code: $http_status."
    exit 0 # Success
else
    echo "Error: Failed to upload the file. Server responded with HTTP Status Code: $http_status" >&2
    exit 1 # Failure
fi

