#!/bin/bash

if [ $# -ne 2 ]
	then
		echo "Usage: $0 USERNAME GITHUBPAT"
		exit 3
fi

declare -a dirs
i=1
for d in */
do
	if [[ "${d%/}" =~ enterprise-cloud.* ]]
	then
		dirs[i++]="${d%/}"
	fi
done
# Add any repos that does not match enterprise-cloud.* below
dirs[i++]=tech-toc_live

echo "Refreshing PAT in ${#dirs[@]} repositories"
for((i=1;i<=${#dirs[@]};i++))
do
	cd ${dirs[i]}
	git remote remove origin
	echo "Refreshing PAT for ${dirs[i]}"
	git remote add origin https://$1:$2@github.com/tr/${dirs[i]}.git
	cd ..
done
