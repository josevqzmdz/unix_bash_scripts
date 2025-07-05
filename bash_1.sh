#!/bin/bash
# 1
# write a program to count the number of times each word is present in a string 
# and save it in a dictionary

sentence = "sample sentence with words to count in a dictiorary"
word_count = {}
for word in sentence.split():
    word_count[word] = word_count.get(word, 0) + 1

print(word_count

# 2
# three members have the same password, one I have to change; write a script for 
# this example

username="user1"
new_password="new_password"
sudo passwd "$username" <<<"$new_password"$'\n'"$new_password"$'\n'

# 3
# write a script to push repository and build jobs in jenkins
git push origin master
curl -X POST https://jenkins-server/job/job-name/build

# 4
# what are EC2 and VPC and how can we create them?
aws ec2 run-instances --image-id ami-123456 --instance-type t2.micro --key-name my-key --subnet-id subnet-123456
aws ec2 create-vpc --cidr-block 10.0.0.0/16

# 5
# https://github.com/bobbyiliev/introduction-to-bash-scripting/blob/main/ebook/en/content/005-bash-user-input.md

# this thing receives user input
#!/bin/bash

echo "whats your name"
read name

echo "hi! $name"

# 6) you can pass arguments to your shell script when you execute it, you just need
# to write it right after the name of your script
# sudo ./bash_1.sh <your_argument>

# detects memory usage of the machine
#!/bin/bash

cronfile=memory_protect.sh  # this file detects itself
path=$(pwd)                 # this is the path to the file
percent_allowed=70          # this is the max memory allowed before action

has_cron(){
    # is this file inside the cron?
    if crontab -l | egrep -v '^$|^#' | grep -q $cronfile; then
        return 1
    else
        return 0
    fi
}

test_memory(){
    memusage=$(top -n 1 -b | grep "Mem")
    MAXMEM=$(echo $memusage | cut -d" " -f2 | awk '{print substr($0,1,length($0)-1)}')
    USEDMEM=$(echo $memusage | cut -d" " -f2 | awk '{print substr($0,1,length($0)-1)}')

    USEDMEM1=$(expr $USEDMEM \* 100)
    PERCENTAGE=$(expr $USEDMEM1 / $MAXMEM)

    [[ $PERCENTAG>$percent_allowed]] && return 1 || return 0
}

if has_cron
then 
    # runs this script every 5 min
    crontab -l > mycron

    # echo new cron into cron files
    echo "*/5 * * * * $path/$cronfile" >> mycron

    # install new cron file
    crontab mycron
    rm mycron

else
    echo "cron present"
fi

if test_memory;
then
   echo "memory exceeding 70%. clearig up memory"
   echo "etc/init.d/nginx restart"
   echo "echo/init.d/php-fpm restart" 


# another code for getting CPU and RAM use
# https://unix.stackexchange.com/questions/119126/command-to-display-memory-usage-disk-usage-and-cpu-load

# 1 get total average CPU use of the past minute
avg_cpu_use=$(uptime)
# split response
IFS=',' read -ra avg_cpu_use_arr <<< "$avg_cpu_use"

# 2 find CPU use
avg_cpu_use=""
for iii in "${avg_cpu_use_arr[@]}"; do :
    if [[ $iii == *"load average"]]; then 
        avg_cpu_use=$iii
        break
    fi
done

# 3 create response
# print CPU values
avg_cpu_use=$(echo ${avg_cpu_use:16})
if [[ -z "${avg_cpu_use//}"]]; then
    avg_cpu_use="CPU: N/A%%"
    exit -1
else
    avg_cpu_use="CPU: ${avg_cpu_use}%%"
fi

# 4 get RAM use
ram_use=$(free -m)
# split responses by new lines
IFS=$'\n' read -rd '' -a ram_use_arr <<< "$ram_use"
# remove extra spaces
ram_use=$"{ram_use_arr[1]}"
ram_use=$(echo "$ram_use" | tr -s " ")

# 5 split response by spaces
IFS=' ' read -ra ram_use_arr <<< "$ram_use"
# 6 get variables

total_ram="${ram_use_arr[1]}"
ram_use="${ram_use_arr[2]}"
ram_use="RAM: ${ram_use}/${total_ram} MB"

echo $avg_cpu_use
echo $ram_use

