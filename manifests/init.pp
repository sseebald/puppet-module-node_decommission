class node_decommission {
  File {  
    ensure  => directory,
    purge   => true,
    recurse => true,
    force   => true,
  }
  Service {
    ensure => stopped,
  }
  file {'/etc/puppetlabs/mcollective/ssl':}

  file {'/etc/puppetlabs/puppet/ssl':}

  service {'pe-httpd':}

  service {'pe-mcollective':}
}
