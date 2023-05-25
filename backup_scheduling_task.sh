#!/bin/bash

if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi


targetDirectory=$1
destinationDirectory=$2


echo "$1"
echo "$2"


currentTS=`date +"%s"`


backupFileName="backup-[$currentTS].tar.gz"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...


origAbsPath=$(pwd)


cd $2
destDirAbsPath=$(pwd)



cd $origAbsPath
cd $targetDirectory


yesterdayTS=$(($currentTS - 24 * 60 * 60))
declare -a toBackup


for file in $(ls -r) 
do

  if ((`date -r $file +%s` > $yesterdayTS))
  then

    toBackup+=($file)
  fi
done


tar -czvf $backupFileName ${toBackup[@]}
 
mv $backupFileName $destDirAbsPath

