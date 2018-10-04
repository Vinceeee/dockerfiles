#!/bin/bash

FN=$1

if [ -z $FN ];then
	echo "file name must be specified!"
	exit 8
fi

while read REPOSITORY TAG IMAGE_ID
do
	echo "== Tagging $REPOSITORY $TAG $IMAGE_ID =="
	docker tag "$IMAGE_ID" "$REPOSITORY:$TAG"
done < $FN

