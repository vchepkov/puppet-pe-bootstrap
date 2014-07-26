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
