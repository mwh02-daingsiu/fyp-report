#!/bin/bash

FS_TO_TEST=(testext2fyp testext2orig)
OUTPUTS=outputs

mkdir -p "$OUTPUTS"

for FS in "${FS_TO_TEST[@]}"; do
	MNT="/media/$FS"
	OUTPUT_FS="$OUTPUTS/$FS"

	mkdir -p "$OUTPUT_FS"

	sync
	sudo tee /proc/sys/vm/drop_caches <<< 3

	fs_mark -k -d "$MNT/test_fs_mark" -s 1048576 -n 10240 -r 64 -v > "$OUTPUT_FS/fs_mark.log"
done
