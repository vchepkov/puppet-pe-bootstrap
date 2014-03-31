class webhooks (
  $webhook_port = '9090',
  $webhook_logdir = '/var/log/webhook',
){

  package { 'sinatra':
    ensure   => present,
    provider => pe_gem,
  }

  file { $webhook::webhook_logdir:
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
}
