class puppet_bootstrap (
  $r10k_enable = true,
  $r10k_mco_enable = true,
  $r10k_repo,
){

  require stdlib

  validate_bool($r10k_enable)
  validate_bool($r10k_mco_enable)

  stage { 'bootstrap':
      before => Stage['main'],
  }

  class {'puppet_bootstrap::config':
    stage => 'bootstrap',
  }
  
  if (true == $r10k_enable) {
    class { 'r10k': 
      remote       => $r10k_repo,
      mcollective  => $r10k_mco_enable,
      r10k_basedir => "${::settings::confdir}/environments",
    }
  }
}

class puppet_bootstrap::config {
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
    value             => '$confdir/environments/$environment/manifests',
  }

  file { 'hiera_config':
    path              => "$::settings::hiera_config",
    ensure            => file,
    content           => template("${module_name}/hiera.yaml.erb"),
  }
}
