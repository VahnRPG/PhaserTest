skipcompile=0

if [ $# -ge 1 ]
then
	if [ $1 = "-m" ]
	then
		override=1
	else
		override=0
	fi
	if [ $# -ge 2 ]
	then
		#echo "hey"
		if [ $2 = "-w" ]
		then
			skipcompile=1
		else
			skipcompile=0
		fi
	fi
else
	override=0
fi
#Must be root, or override that requirement with the -m “mere mortal” option.
if [ `whoami` != "root" -a $override -eq 0 ]
then
	echo $0": must be root to run this script"
	exit
fi

preserveCount=5

if [ `whoami` = "root" ]; then
	source /root/.nvm/nvm.sh
fi

if test -e "dist-0"
then
	echo "dashbuild: previous failed build detected, overwriting."
	rm -rf dist-0
else
	echo "dashbuild: clean build target detected, proceeding with impunity."
fi

if [ $skipcompile = 0 ]
then
	yarn build
fi

#echo "build would have succeeded"
if [ $? -eq 0 ]
then
	#success
	echo "dashbuild: yarn build succeeded"

	#figure out the oldest version
	checkVersion=1
	checkFile="dist-"$checkVersion
	#echo "now checking " $checkFile
	while test -e $checkFile
	do
		checkVersion=$((checkVersion + 1))
		checkFile="dist-"$checkVersion
		#echo "now checking next " $checkFile
	done
	checkVersion=$((checkVersion - 1))
	#echo "highest version is " $checkVersion

	#checkVersion is now the highest previous number
	#if the highest number is our limit, we can delete it
	if [ $checkVersion -eq $preserveCount ]
	then
		victim="dist-"$checkVersion
		#echo "dashbuild: deleting oldest version, " $victim
		rm -rf $victim
		checkVersion=$(($checkVersion - 1))
	fi

	#now we can commence with the propogation. $checkVersion is the first version for the source of the copy
	current=$checkVersion
	while [ $current -gt 0 ]
	do
		source="dist-"$current
		dest="dist-"$((current+1))
		#echo "dashbuild: renaming " $source " to " $dest
		mv $source $dest
		current=$((current - 1))
	done
	ls

	if test -e "dist"
	then
		#echo "dashbuild: moving dist to dist-1"
		mv dist dist-1

	fi
	#echo "moving production build to live version."
	if [ $skipcompile = 0 ]
	then
		mv dist-0 dist
		git status > dist/git-status.txt
	fi
	#echo "dashbuild: done propogating versions"
	echo "dashbuild: NOTE - IF YOU HAVE DIST+ FOLDERS, NOW WOULD BE THE TIME TO DELETE THEM!"
else
	# failure
	echo "dashbuild: yarn build failed, restoring old version"
	rm -rf dist-0
fi
