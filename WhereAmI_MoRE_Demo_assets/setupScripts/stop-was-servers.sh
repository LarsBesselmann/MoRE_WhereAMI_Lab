#!/bin/bash
echo "Stopping IHS..."
cd /home/techzone/IBM/HTTPServer/bin
./apachectl stop
echo "Stopping WAS servers..."
cd /home/techzone/IBM/WebSphere/AppServer/profiles/AppSrv01/bin
./stopServer.sh tWASMember1 -username techzone -password IBMDem0s!
cd /home/techzone/IBM/WebSphere/AppServer/profiles/AppSrv02/bin
./stopServer.sh tWASMember2 -username techzone -password IBMDem0s!
echo "Stopping node agents..."
cd /home/techzone/IBM/WebSphere/AppServer/bin
./stopNode.sh -profileName AppSrv01 -username techzone -password IBMDem0s!
./stopNode.sh -profileName AppSrv02 -username techzone -password IBMDem0s!
echo "Stopping Deployment Manager..."
./stopManager.sh -username techzone -password IBMDem0s!
echo "All servers have been stopped!