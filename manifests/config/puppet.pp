class master::config::puppet (
  Boolean $agent = false,
  Hash $main     = {},
  Hash $master   = {},
) inherits master::params {

  if (!$agent) {
    $default_master_section = {
      'vardir'   => '/opt/puppetlabs/server/data/puppetserver',
      'logdir'   => '/var/log/puppetlabs/puppetserver',
      'rundir'   => '/var/run/puppetlabs/puppetserver',
      'pidfile'  => '/var/run/puppetlabs/puppetserver/puppetserver.pid',
      'codedir'  => '/etc/puppetlabs/code',
      'autosign' => true,


    }
    $_master = $default_master_section + $master
  }

  $default_main_section = {}

  $_main = $default_main_section + $main

  include master::config::conf

  master::config::add { "master":
    content => template('master/puppet.conf.erb'),

  }

}