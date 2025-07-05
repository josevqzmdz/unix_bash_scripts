#!/bin/sh

cronfile=memory_protect.sh    #NOTE THIS SHOULD DETECT IT'S SELF
path=$(pwd)                   #this is the path to the file 
percent_allowed=70            #this should be max memory before action

has_cron(){
    #is the file in the cron?
    #return 0 #returning this just to test should
    #be the next line but it's not working
    if crontab -l | egrep -v '^$|^#' | grep -q $cronfile; then
      return 1
    else
      return 0
    fi
}
test_memory(){
    memusage=$(top -n 1 -b | grep "Mem")
    MAXMEM=$(echo $memusage | cut -d" " -f2 | awk '{print substr($0,1,length($0)-1)}')
    USEDMEM=$(echo $memusage | cut -d" " -f4 | awk '{print substr($0,1,length($0)-1)}')

    USEDMEM1=$(expr $USEDMEM \* 100)
    PERCENTAGE=$(expr $USEDMEM1 / $MAXMEM)
    #if it's above 80% alert
    [[ $PERCENTAG>$percent_allowed ]] && return 1 || return 0
}

if has_cron;
then
    #was not here so add
    #run this script every 5 mins
    #crontab -e */5 * * * $path/$cronfile
    #cat <(crontab -l) <(echo "*/5 * * * $path/$cronfile") | crontab -
    crontab -l > mycron

    # Echo new cron into cron file
    echo "*/5 * * * * $path/$cronfile" >> mycron

    # Install new cron file
    crontab mycron
    rm mycron
else
    echo "cron present"
fi

if test_memory;
then
    #clear some memory
    echo "/etc/init.d/nginx restart"
    echo "/etc/init.d/php-fpm restart"
fi

# from here
# https://unix.stackexchange.com/questions/91789/script-to-test-for-memory-usage
# checks if the memory usage of, anything really,
# in this case, a docker container
# goes up, for this one the limit will be 70%
# and it will write as much in the logs of docker