#!/bin/bash

if [ "$(whoami)" != "root" ]
then
  echo "You have to run this script as Superuser!"
  exit 1
fi

# Get Memory Information
freemem_before=$(cat /proc/meminfo | grep MemFree | tr -s ' ' | cut -d ' ' -f2) && freemem_before=$(echo "$freemem_before/1024.0" | bc)
cachedmem_before=$(cat /proc/meminfo | grep "^Cached" | tr -s ' ' | cut -d ' ' -f2) && cachedmem_before=$(echo "$cachedmem_before/1024.0" | bc)

# Test sync
if [ "$?" != "0" ]
then
  echo "Something went wrong, It's impossible to sync the filesystem."
  exit 1
fi

# Clear Filesystem Buffer using "sync" and Clear Caches
sync && echo 3 > /proc/sys/vm/drop_caches

freemem_after=$(cat /proc/meminfo | grep MemFree | tr -s ' ' | cut -d ' ' -f2) && freemem_after=$(echo "$freemem_after/1024.0" | bc)

# Output Summary
echo -e "This freed $(echo "$freemem_after - $freemem_before" | bc) MiB, so now you have $freemem_after MiB of free RAM.\n\n"

echo "WebService Validation\n\n"

pgrep="pgrep -f"
pname="mysql"
$pgrep ${pname}

if [ $? -eq 1 ]
then
  echo "Mysql dont Work, restarting...\n\n"
  /etc/init.d/mysql restart
  /etc/init.d/apache2 restart
else
  echo 'Mysql Ok, do not worry ;)'
fi
exit
