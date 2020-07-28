#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESTORE="\e[39"
path=$(pwd)
clear

# Argument Check
if [[ $# -eq 0 ]]
then
	echo -e "${RED}[*] ${YELLOW}Please specify username.
Example :${MAGENTA} ./insta.sh Raunak"
elif [[ $# -eq 1 ]]
then

	echo -e $GREEN"-=-=-=-=[ Download Instagram Photos By Khanejo ]=-=-=-=-"$CYAN
	echo ""
	echo ""
	# Check Username Public Or Private
	echo -e $RED"[!]${CYAN} Checking username $1 ... "
	echo ""
	check=$(curl -s "https://www.instagram.com/$1/")
	if [[ $check =~ 'The link you followed may be broken, or the page may have been removed.' ]]; then
		echo -e $RED"[-]${BLUE} [ $1 ] ${RED} NOT FOUND!"
		exit
	elif [[ ${check} =~ 'is_private": true' ]]; then
		echo -e $YELLOW"[-]${BLUE} [ $1 ] ${RED}PRIVATE ACCOUNT "
		exit
	else
		echo -e $GREEN"[+]${BLUE} [ $1 ] ${GREEN}FOUND !"
	fi
	# Get Images
	echo ""
	getData=$(curl -s https://www.instagram.com/$1/ | grep -Po '(?<="display_url":")[^",]*')
	echo $getData >> list_link.temp3x
	echo -e $RED"[!]${BLUE} DOWNLOADING IN PROCCESS ...."
	sleep 1
	dir=$1_posts
	mkdir -p $dir
	num=1
	for dl in $(cat list_link.temp3x)
	do
		echo -e  -n $RED"[!]${BLUE} $dl ... "
		filename=$dir/$1_$((num++)).jpg
		wget $dl -O $filename > /dev/null 2>&1
		if [[ -f $filename ]]; then
			echo -e $GREEN"[OK]"$BLUE
		else
			echo -e $YELLOW"[ERROR]"$BLUE
		fi
	done
	count=$(ls $dir >> h; wc -l h | awk '{print $1}')
	echo -e "[${MAGENTA}$count ${GREEN}File(s) saved to ${YELLOW} $dir ${BLUE} ]"
	rm list_link.temp3x h
fi
