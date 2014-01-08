class node_decommission::master($target=undef) {

  file_line { 'site.pp':
    path => '/etc/puppetlabs/puppet/environments/production/manifests/site.pp',
    line => "node ${target} {include node_decommissions::client}",
  }
  #
  #  exec {'remote puppet run':
  #    command => "sudo -i -u peadmin mco puppet runonce -I ${target}",
  #    path    => '/opt/puppet/bin',
  #  }
  #
  #  exec {'deactivate':
  #    command => "puppet node deactivate ${target}",
  #    path    => '/opt/puppet/bin',
  #  }
  #
  #  exec {'clean':
  #    command => "puppet cert clean ${target}",
  #    path    => '/opt/puppet/bin',
  #  }
  #
  #  service {'pe-httpd':
  #    subscribe => File_line['site.pp'],
  #  }
  #
}
