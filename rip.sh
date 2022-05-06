#!/bin/sh

pw_name="Spotify Ripper"
pw_account="1161933296"

if ! cli_password=$(security find-generic-password -w -s "$pw_name" -a "$pw_account"); then
  echo "could not get password, error $?"
  exit 1
fi

output_dir="$(pwd)"/output
destination_dir="/Volumes/T5_djogo/Music/Reference Tracks/"

docker run --mount type=bind,source="$output_dir",target=/output spotify-ripper --wav --directory /output --user $pw_account --password $cli_password spotify:track:$1

mv "$output_dir"/* "$destination_dir"

open "$destination_dir"
