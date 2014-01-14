#!/bin/bash

NODENAME=$1

#add node to no mcollective group
sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production node:addgroup["${NODENAME}","no mcollective"]

sleep 30

while [ sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production node:listgroups["mcollective"] | grep $NODENAME ]
do
	sleep 5
done

#run puppet to remove mcollective
sudo -i -u peadmin mco puppet runonce -I $NODENAME

#clean the cert
/opt/puppet/bin/puppet cert clean $NODENAME

#deactive the node	
/opt/puppet/bin/puppet node deactivate $NODENAME

#remove classification from the master
sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production nodeclass:del["node_decommission::master"]
