#!/bin/bash

mco find --wc pe_mcollective > /etc/puppetlabs/puppet/environments/production/modules/puppet_destroy/files/nodes.txt

for i in nodes.txt
do
	puppet node deactive $i
	puppet node destroy $i
done

#mco rpc puppetca revoke certname=$1
#mco rpc filemgr remove file=/etc/puppetlabs/mcollective/ssl/clients/*

