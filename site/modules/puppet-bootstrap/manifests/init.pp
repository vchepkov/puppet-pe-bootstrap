class puppet-bootstrap {
  stage { 'bootstrap':
      before => Stage['main'],
  }

  class {'puppet-bootstrap::config':
    stage => 'bootstrap',
  }
}

class puppet-bootstrap::config {
  ini_setting { 'puppet master module path':
    path              => "$::settings::config",
    ensure            => present,
    key_val_separator => '=',
    section           => 'main',
    setting           => 'modulepath',
    value             => '$confdir/environments/$environment/modules:$confdir/environments/$environment/site/modules:/opt/puppet/share/puppet/modules',
  }
    
  ini_setting { 'puppet manifest path':
    path              => "$::settings::config",
    ensure            => present,
    key_val_separator => '=',
    section           => 'master',
    setting           => 'manifest',
    value             => '$confdir/environments/$environment/manifests/site.pp',
  }

  file { 'hiera_config':
    path              => "$::settings::hiera_config",
    ensure            => file,
    content           => template("${module_name}/hiera.yaml.erb"),
  }
}
