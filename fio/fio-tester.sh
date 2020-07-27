#!/bin/bash

FS_TO_TEST=(testext2orig testext2fyp)
OUTPUTS=outputs
PROFILES=profiles

mkdir -p "$OUTPUTS"

for FS in "${FS_TO_TEST[@]}"; do
	MNT="/media/$FS"
	OUTPUT_FS="$OUTPUTS/$FS"
	PROFILES_FS="$PROFILES/$FS"

	mkdir -p "$OUTPUT_FS"

	for job in $PROFILES_FS/*; do
		jobfile="$job"
		job=$(basename $job .fio)
		sync
		sudo tee /proc/sys/vm/drop_caches <<< 3

		fio --bandwidth-log --output="$OUTPUT_FS/$job.output" $jobfile
	done
done
