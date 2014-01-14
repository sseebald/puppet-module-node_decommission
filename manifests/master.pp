class node_decommission::master($target=undef) {

  file {'/etc/puppetlabs/puppet/environments/production/manifests/site.pp.bak':
    ensure => file,
    source => '/etc/puppetlabs/puppet/environments/production/manifests/site.pp',
  }

  file_line { 'site.pp':
    path   => '/etc/puppetlabs/puppet/environments/production/manifests/site.pp',
    line   => "node ${target} {include node_decommission::client}",
    before => Exec['run puppet'],
  }

  file {'puppet-destroy':
    ensure => file,
    path   => '/opt/puppet/bin/puppet-destroy',
    source => 'puppet:///modules/node_decommission/node_destroy.sh',
  }

  exec {'run puppet':
    command => "sudo -i -u peadmin mco puppet runonce -I ${target}",
    path    => '/usr/bin',
    before  => Exec['node_destroy'],
  }

  exec {'node_destroy':
    command => "puppet destroy ${target}",
    path    => ['/opt/puppet/bin','/usr/bin'],
    require => File['puppet-destroy'],
  }
 
  file {'/etc/puppetlabs/puppet/environments/production/manifests/site.pp':
    ensure => file,
    source => '/etc/puppetlabs/puppet/environments/production/manifests/site.pp.bak',
  }

  service {'pe-httpd':
    subscribe => Exec['node_destroy'],
  }

}
