#!/usr/bin/env sh

set -e

URI=$@
# make a temporary dir
TMPDIR="$(mktemp -d)"
cd $TMPDIR

# Region must be specified to override the environment variables 
# but doesn't need to match the actual region of the bucket to download objects.
aws s3 cp $URI . --region us-east-1 1>/dev/null 

FILENAME=$(basename -- $URI)
if [ -f $FILENAME ]; then # if a file named $FILENAME exists
  cat $FILENAME
else
  echo "Error in plugin 's3-downloader': $FILEPATH does not exists" >&2
  exit 1
fi

# remove the temporary dir
rm -rf $TMPDIR