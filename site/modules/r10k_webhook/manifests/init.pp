class r10k_webhook (
  $port = '9090',
  $logdir = '/var/log/r10k_webhook',
){

  package { 'sinatra':
    ensure   => present,
    provider => pe_gem,
  }

  file { $r10k_webhook::logdir:
    ensure => directory,
    owner  => peadmin,
    group  => peadmin,
    mode   => '0755',
  }

  file { '/usr/local/sbin/r10k_webhook':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0555',
    content => template("${module_name}/r10k_webhook.erb"),
    require => Package['sinatra'],
  }

  file { '/etc/init.d/r10k_webhook':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0555',
    content => template("${module_name}/r10k_webhook.init.erb"),
    require => File['/usr/local/sbin/r10k_webhook'],
  }

  service { 'r10k_webhook':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => [ File['/etc/init.d/r10k_webhook'], File['/usr/local/sbin/r10k_webhook'], ],
  }

  package { 'logrotate':
    ensure  => installed,
  }

  file { '/etc/logrotate.d/r10k_webhook':
    ensure => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("${module_name}/logrotate.erb"),
    require => Package['logrotate'],
  }
}
