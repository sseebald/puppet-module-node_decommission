class node_decommission::client {
  
 File {  
    ensure  => absent,
    purge   => true,
    recurse => true,
    force   => true,
  }
  Service {
    ensure => stopped,
  }
    
  file {'/etc/puppetlabs/puppet/ssl':}
  
  file {'/etc/puppetlabs/mcollective/ssl/':}
 
  service {'pe-httpd':}

}
