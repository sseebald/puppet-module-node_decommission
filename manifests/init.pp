class node_decommission {
  
  #  define node_decommission ($node = $title, $action) {
  #    exec {'node_destroy.sh':
  #      command => "/etc/puppetlabs/puppet/environments/production/modules/node_decommission/files/node_destroy.sh ${node} ${action}",
  #      path    => ['/bin'],
  #      cwd     => '/etc/puppetlabs/puppet/environments/production/modules/node_decommission/files',
  #    }
  #  }
  #  
  #  node_decommission {'centos64a': 
  #    action => 'destroy',
  #  }
  #
  File {  
    ensure  => absent,
    purge   => true,
    recurse => true,
    force   => true,
  }
  Service {
    ensure => stopped,
  }
  
  #  file {'/etc/puppetlabs/mcollective/ssl':
  #    before => File['/etc/puppetlabs/puppet/ssl/'],
  #  }
  # 
  
  file {'/etc/puppetlabs/puppet/ssl':}
  
  #  
  # 
  # file {'/etc/puppetlabs/puppet/ssl/private_keys': 
  #   before => File['/etc/puppetlabs/puppet/ssl/public'],
  # }
  # 
  # file {'/etc/puppetlabs/puppet/ssl/public': 
  #   before => File['/etc/puppetlabs/puppet/ssl/certs'],
  # }
  # 
  # file {'/etc/puppetlabs/puppet/ssl/certs': 
  #   require => File['/etc/puppetlabs/puppet/ssl/public'],
  # }

  # file {'/etc/puppetlabs/puppet/ssl/certificate_requests': 
  #   before => File['/etc/puppetlabs/puppet/ssl/private_keys'],
  # }
  #
  service {'pe-httpd':
    #before => Service['pe-mcollective'],
  }

  #  service {'pe-mcollective':
  #    before => File['/etc/puppetlabs/mcollective/ssl'],
  #  }
}
