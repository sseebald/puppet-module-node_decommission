#!/bin/bash

NODENAME=$1
STATUS=$2

#remove node from pe_mcollective group, add to pe_no_mcollective group
sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production node:addgroup["${NODENAME}","no mcollective"] 

#clasify node with code to remove mcollective certs
sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production nodegroup:add["node_decommission"] nodeclass:add["node_decommission"] nodegroup:addclass["node_decommission","node_decommission"] node:addgroup["${NODENAME}","node_decommission"]

#run puppet to remove mcollective
sudo -i -u peadmin mco puppet runonce -A $NODENAME

sleep 60

#clean the cert
#/opt/puppet/bin/puppet cert clean $NODENAME

#deactive the node	
#/opt/puppet/bin/puppet node deactivate $NODENAME

if [ "$STATUS" == "destroy" ]; then
	echo removing?
	sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production node:del["${NODENAME}"]
fi

#sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production nodegroup:del["node_decommission"] nodeclass:del["node_decommission"] 

#restart the service
#service pe-httpd restart
