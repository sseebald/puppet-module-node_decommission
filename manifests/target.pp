class node_decommission::target inherits pe_mcollective::shared_key_files {
  
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
