#!bin/bash
<<doc
Name: Sharan Rathnakumar
Date: 29th October 2022
Descripton: Instagram Analyser
doc


NC='\033[0m'
White='\033[0;37m'
Red='\033[0;31m'
Green='\033[0;32m'
Blue='\033[0;34m'  
Yellow='\033[0;33m'

clear
touch mutual.txt
touch Unfollower.txt
touch Fans.txt
echo -e "<-------------Insta Analyser-------------->\n\n\n"
function start()
{
read -p "Enter followers list filename (CSV): " followers
read -p "Enter following list filename (CSV): " following
}

function main()
{
        start
        followers=(`cat $followers | cut -d "," -f2 | tr "\n" " "`)
        following=(`cat $following | cut -d "," -f2 | tr "\n" " "`)

        countFollowers=${#followers[@]}
        countFollowing=${#following[@]}


#<-----------------------------------Mutual Followers------------------------------------>

        for i in `seq 0 $(($countFollowing-1))`
        do
                for j in `seq 0 $(($countFollowers-1))`
                do
                        if [ "${following[$i]}" == "${followers[$j]}" ]
                        then
                                echo "${following[i]}" >> mutual.txt
                        fi
                done
        done
        mutualFollowers=(`cat mutual.txt | tr "\n" " "`)
#       echo "${mutualFollowers[@]}"

        countmutualFollowers=${#mutualFollowers[@]}

#<----------------------------------Not Following Back------------------------------------>

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

#<--------------------------------You are Not Following------------------------------------->


        flag=0
        for i in `seq 0 $(($countFollowers-1))`
        do
                for j in `seq 0 $(($countmutualFollowers-1))`
                do
                        if [ "${followers[$i]}" == "${mutualFollowers[$j]}" ]
                        then
                                flag=1
                        fi
                done
                if [ $flag -eq 0 ]
                then
                        echo "${followers[$i]}" >> Fans.txt
                fi
                flag=0
        done
        echo -e "\n\n${White}Mutual Followers :\n${Green}`cat mutual.txt`${NC}"
        echo -e "\n\n${White}Not Following You Back :\n${Red}`cat Unfollower.txt`${NC}" 
        echo -e "\n\n${White}You are Not Following Back :\n${Yellow}`cat Fans.txt`${NC}"
        rm mutual.txt
        rm Unfollower.txt
        rm Fans.txt

}
main
