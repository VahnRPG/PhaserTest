#!/bin/bash
if [ $# = 1 ]
then
	if [ $1 = "-m" ]
	then
		override=1
	else
		override=0
	fi
else
	override=0
fi
#Must be root, or override that requirement with the -m "mere mortal" option.
if [ `whoami` != 'root' -a $override -eq 0 ]
then
	echo $0": must be root to run this script"
	exit
fi

if [ ! -e "dist-1" ]
then

	echo $0": no 'dist-1' directory to rollback from"
	exit
fi

preserveCount=5

#First, roll forwards. That should give us space to move the - versions up.
#figure out the oldest version. Keep checking for ones that might be there
#until we find the one that isn’t.
checkVersion=1
checkFile="dist+"$checkVersion
#echo “now checking ” $checkFile
while test -e $checkFile
do
	checkVersion=$((checkVersion + 1))
	checkFile="dist+"$checkVersion
	#echo “now checking next ” $checkFile
done
checkVersion=$((checkVersion - 1))

#if we are at the limit, then delete it. It will get replaced when the the next oldest is moved up
if [ $checkVersion -eq $preserveCount ]
then
	# have the maximum number of perserved dist+ directories. Delete and
	# start with the next one.
	echo $0": deleting dist+"$preserveCount
	rm -rf "dist+"$preserveCount
	checkVersion=$((preserveCount-1))
fi


#checkVersion now contains the highest version number for a "dist+" directory.
#Proceed to roll dist+ versions up to a higher number
current=$checkVersion
while [ $current -gt 0 ]
do
	source="dist+"$current
	dest="dist+"$((current+1))
	echo $0": renaming " $source " to " $dest
	mv $source $dest
	current=$((current - 1))
done

# now we can move the dist, if we have one
if test -e 'dist'
then
	echo $0": renaming dist to dist+1"
	mv dist dist+1
fi

if test -e 'dist-0'
then
	echo $0": deleting the dist-0 directory"
	rm -rf dist-0
fi

#move dist-1 into the current dist directory for NGINX to find.
if test -e 'dist-1'
then
		echo $0": renaming dist-1 to dist"
		mv dist-1 dist
fi

#no we can propgate the older ones up the stack. It will automatically stop when we are out of dirs.
current=2
while test -e "dist-"$current
do
	source="dist-"$current
	dest="dist-"$((current-1))
	echo $0": renaming " $source " to " $dest
	mv $source $dest
	current=$((current + 1))
done
