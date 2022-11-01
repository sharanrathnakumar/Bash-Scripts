#!bin/bash
<<doc
Name: Sharan Rathnakumar
Date: 29th October 2022
Descripton: Instagram Analyser
doc

clear
touch mutual.txt
touch Unfollower.txt
echo -e "<-------------Insta Analyser-------------->\n\n\n"
function start()
{
read -p "Enter followers list filename (CSV): " followers
read -p "Enter following list filename (CSV): " following
}

function Initialisation()
{
	start
	followers=(`cat $followers | cut -d "," -f2 | tr "\n" " "`)
	following=(`cat $following | cut -d "," -f2 | tr "\n" " "`)

	countFollower=${#followers[@]}
	countFollowing=${#following[@]}
	
	for i in `seq 0 $(($countFollowing-1))`
	do
		for j in `seq 0 $(($countFollower-1))`
		do
			if [ "${following[$i]}" == "${followers[$j]}" ]
			then
				echo ${following[i]} >> mutual.txt
			fi
		done
	done
	mutualFollowers=(`cat mutual.txt | tr "\n" " "`)
#	echo "${mutualFollowers[@]}"

	countmutualFollowers=${#mutualFollowers[@]}
	flag=0
	for i in `seq 0 $(($countFollowing-1))`
	do
		for j in `seq 0 $(($countmutualFollowers-1))`
		do
			if [ "${following[$i]}" == "${mutualFollowers[$j]}" ]
			then
				flag=1
			fi
		done
		if [ $flag -eq 0 ]
		then
			echo "${following[$i]}" >> Unfollower.txt
		fi
		flag=0
	done
	echo -e "\n\nMutual:\n`cat mutual.txt`"
	echo -e "\n\nNot Following:\n`cat Unfollower.txt`" 
	rm mutual.txt
	rm Unfollower.txt

}
Initialisation
