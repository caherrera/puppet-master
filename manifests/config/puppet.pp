class master::config::puppet (
  Hash $main   = {},
  Hash $master = {},
) {

  $default_master_section = {
    'vardir'  => '/opt/puppetlabs/server/data/puppetserver',
    'logdir'  => '/var/log/puppetlabs/puppetserver',
    'rundir'  => '/var/run/puppetlabs/puppetserver',
    'pidfile' => '/var/run/puppetlabs/puppetserver/puppetserver.pid',
    'codedir' => '/etc/puppetlabs/code',


  }
  $default_main_section = {}

  $_master = $default_master_section + $master
  $_main = $default_main_section + $main

  file { $master::params::puppetconf:
    content => template('master/puppet.conf.erb'),
    notify  => Class[master::config::ca]
  }


}