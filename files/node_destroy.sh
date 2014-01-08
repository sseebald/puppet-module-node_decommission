#!/bin/bash

NODENAME=$1

#run puppet to remove mcollective
sudo -i -u peadmin mco puppet runonce -I $NODENAME

#clean the cert
/opt/puppet/bin/puppet cert clean $NODENAME

#deactive the node	
/opt/puppet/bin/puppet node deactivate $NODENAME


