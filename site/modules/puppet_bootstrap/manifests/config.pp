class puppet_bootstrap::config {
  ini_setting { 'puppet master module path':
    ensure            => present,
    path              => $::settings::config,
    key_val_separator => '=',
    section           => 'main',
    setting           => 'modulepath',
    value             => '$confdir/environments/$environment/modules:$confdir/environments/$environment/site/modules:/opt/puppet/share/puppet/modules',
  }

  ini_setting { 'puppet manifest path':
    ensure            => present,
    path              => $::settings::config,
    key_val_separator => '=',
    section           => 'master',
    setting           => 'manifest',
    value             => '$confdir/environments/$environment/manifests',
  }

  file { 'hiera_config':
    ensure            => file,
    path              => $::settings::hiera_config,
    content           => template("${module_name}/hiera.yaml.erb"),
  }
}
