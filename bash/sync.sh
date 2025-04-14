#!/usr/bin/env bash

set -e

check_command_available() {
    if ! command -v $1 &> /dev/null
    then
        echo "The required dependency '$1' could not be found, please install it."
        exit
    fi
}

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <Url> <OutPutPath> <Username> <Password>" >&2
    echo "Error: Incorrect number of arguments provided." >&2
    exit 1
fi

check_command_available "jq"

url=$1
outputPath=$2
username=$3
password=$4

script_path="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P)"

json_response=$(curl -Ss -u "$username:$password" $url?json)

echo $json_response | jq -c '.[]' | while read -r item; do
    name=$(echo "$item" | jq -r .name)
    if ! [ -f "$outputPath/$name" ]; then
        $script_path/get.sh "$url/$name" "$outputPath" "$username" "$password"
    fi
done

echo "Finished sync."
