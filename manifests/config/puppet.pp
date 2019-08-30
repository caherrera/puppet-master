class master::config::puppet (
  Boolean $agent = false,
  Hash $main     = {},
  Hash $master   = {},
) {

  if (!$agent) {
    $default_master_section = {
      'vardir'  => '/opt/puppetlabs/server/data/puppetserver',
      'logdir'  => '/var/log/puppetlabs/puppetserver',
      'rundir'  => '/var/run/puppetlabs/puppetserver',
      'pidfile' => '/var/run/puppetlabs/puppetserver/puppetserver.pid',
      'codedir' => '/etc/puppetlabs/code',


    }
    $_master = $default_master_section + $master
  }

  $default_main_section = {}

  $_main = $default_main_section + $main

  file { $master::params::puppetconf:
    content => template('master/puppet.conf.erb'),

  }


}