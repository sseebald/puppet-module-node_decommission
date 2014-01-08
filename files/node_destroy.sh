#!/bin/bash

NODENAME=$1
STATUS=$2

#remove node from pe_mcollective group, add to pe_no_mcollective group
sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production node:addgroup["${NODENAME}","no mcollective"] 

#clasify node with code to remove mcollective certs
sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production nodegroup:add["node_decommission"] 
sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production nodeclass:add["node_decommission"] 
sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production nodegroup:addclass["node_decommission","node_decommission"] 
sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production node:addgroup["${NODENAME}","node_decommission"]

#run puppet to remove mcollective
sudo -i -u peadmin mco puppet runonce -I $NODENAME

sleep 60

#clean the cert
/opt/puppet/bin/puppet cert clean $NODENAME

#deactive the node	
/opt/puppet/bin/puppet node deactivate $NODENAME

sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production node:del["${NODENAME}"]

#clean up
#sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production nodegroup:del["node_decommission"] 
#sudo /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production nodeclass:del["node_decommission"] 

#restart the service
service pe-httpd restart
