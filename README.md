puppet-module-node_decommission
===============================

Module to completely decommission a node in Puppet.

Add node_decommission::master to the puppet master node. Pass in the name of the system you want as a parameter 
to the module. Run puppet on the master. Node should now be decommission, MCO should no longer function on target node.


TO-DO: Node needs to be added to the no mcollective group. Currently going to do this through a rake task in the bash script, but it's not implemented yet.
