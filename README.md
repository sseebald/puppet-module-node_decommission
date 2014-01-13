puppet-module-node_decommission
===============================

Module to completely decommission a node in Puppet.

Add node_decommission::master to the puppet master node. Pass in the name of the system you want as a parameter 
to the module. Run puppet on the master. Node should now be decommission, MCO should no longer function on target node.

To-Do:

Error checking around node input
Comments in code
Better way to add node to site.pp
