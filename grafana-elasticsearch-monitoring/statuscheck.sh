#!/bin/bash

CWD=`pwd`
ES="http://localhost:9200/test_index/data"
timestamp=`date +'%Y-%m-%dT%H:%M:%S.%6N'`
stat=`date +'%Y%m%d%H%M%S'`

# Get VM Hostname
        hostname=`hostname` 2> /dev/null

  # System parameters
  # System status UP/DOWN
        status=`uptime | awk '{print $2}'`   
        if [ $status == "up" ];
        then
            status=1
        else
            status=0
        fi

  # No of days from last reboot
        now=`date +'%Y-%m-%d'`  
        rebootDate=`uptime -s | awk '{print $1}'`
        updays=$(echo "( `date -d $now +%s` - `date -d $rebootDate +%s`) / (24*3600)" | bc -l)
        
  # Load on CPU
        cpuload=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
  # Total Memory
        free -m
        totalRam=`free -m | awk 'FNR == 2 {print $2}'`
  # Used Memory
        availRam=`free -m| awk 'FNR == 2 {print $7}'`
		usedRam=`expr $totalRam - $availRam`
  # Disk space
        temp=`df .`
        df .
  # Disk % used
        disk_perc=`echo $temp | awk -F ' ' '{print $12}' | sed 's/.$//'`
  # Disk used
        disk_used=`echo $temp | awk -F ' ' '{print $10}'`
  # Disk total
        disk_total=`echo $temp | awk -F ' ' '{print $9}'`
  # Is reboot required
        if [[ -f /var/run/reboot-required ]] 
        then
	        reboot_required=1
        else
	        reboot_required=0
        fi

# Create json file
	echo "Running at $timestamp"
	echo "{\"timestamp\":\"$timestamp\",\"hostname\":\"$hostname\",\"status\":$status,\"reboot_required\":$reboot_required,\"cpuload\":$cpuload,\"totalRam\":$totalRam,\"usedRam\":$usedRam,\"diskPerc\":$disk_perc,\"diskused\":$disk_used,\"disk_total\":$disk_total}" > $CWD/payload.json

# Send to ES
cat $CWD/payload.json
echo "$ES/$stat"
curl -X POST "$ES/$stat" -d @payload.json --header "Content-Type: application/json"
