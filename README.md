# Auto-Revive-Web-Server
Simple Linux script to revive the web server
This script has the function to clear the server's memory and, as a result, validate if the webserver is running as it should. If not, it will restart the services necessary for the operation of the webserver.

Tested on Debian derivatives.

For other distributions, just change the paths of service and restart call.

# Installation
## Download the auto-revive-web-server.sh

## Give execute permission:
chmod + x auto-revive-web-server.sh

## Schedule service
crontab -e
* / 5 * * * * /path/auto-revive-web-server.sh
