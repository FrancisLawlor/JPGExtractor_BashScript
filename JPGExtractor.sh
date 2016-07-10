#!/bin/bash

#Name: Francis Lawlor
#Email: francis.lawlor@ucdconnect.ie

#Check that appropriate number of arguments are entered.

if [ ! $# -eq 2 ]
	then echo Two arguments required!
	exit
fi

#Check if source directory exists.

if [ ! -d "$1" ]
	then echo Source directory does not exist!
	exit
fi

#Check if destination directory can be written to.

if [ ! -w $2 ]
	then echo Cannot write to this directory!
	exit
fi

#Find all directories with pngs in subdirectories and copy to destination directory

find $1 -name *.png -exec cp {} --parent $2 \;

#If user enters whole path e.g. (/home/user/Desktop/source) for directory instead of relative path, all directories will be copied. Base directory for source folder will be required for finding which folder is needed amongst the copied directories.

base="$(basename $1)"

#Copy the path of the directory with the same name as the base directory of source to variable reqdir.

reqdir=$(find $2 -name *$base -type d)

#Store desired path for aforementioned directory in variable needdir.

needdir=$2/$base

#if the directory isn't where it should be (root of the destination folder) i.e. user has entered absolute paths for directories, then move the directory to the root of the destination folder.

if [[ $reqdir != $needdir ]]
	then
	mv $reqdir $2
fi

#store all root directories in an array

rootdirs=$(find $2 -maxdepth 1 -type d)

#find function adds name of directory itself to the array, as well as sub directories. Remove parent's name from the array.

rootdirs=( "${rootdirs[@]/$2}" )

#iterate through contents of array

for d in $rootdirs
do
	#store base directory of path
	value="$(basename $d)"

	#if directory does not have the same name as the source folder remove it
	if [[ $value != $base ]]
		then
		rm -R $2/$value
	fi
done

#We now have a subdirectory within our destination folder containing everything we need. All we need to do is copy it's contents to the root of the destination folder, and delete that subdirectory.

#Account for possible spaces in file names
accountforspaces=$IFS
IFS=$(echo -en "\b\n")

#FILES contains names of all files in source directory.
FILES=$2/$base/*

#Iterate through directory names
for f in $FILES
	do
		#copy contents of directories to root of destination directory
		cp -R $f $2
	done
IFS=$accountforspaces

#Remove unneeded directory
rm -R $2/$base

#Convert pngs to jpgs in all sub directories.
find $2 -name "*.png" -print0 | xargs -0 mogrify -format jpg

#Delete pngs in all sub directories.
find $2 -name "*.png" -print0 | xargs -0 rm

