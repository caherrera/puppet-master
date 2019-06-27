# Class: master::config
#
# This module manages puppetserver bootstrap and configuration
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class master::config (
  $service_config_file  = $master::service_config_file,
  $service_enable       = $master::service_enable,
  $service_ensure       = $master::service_ensure,
  $java_bin             = $master::java_bin,
  $memory_allocation    = $master::memory_allocation,
  $java_args            = $master::java_args,
  $tk_args              = $master::tk_args,
  $user                 = $master::user,
  $group                = $master::group,
  $install_dir          = $master::install_dir,
  $config               = $master::config,
  $bootstrap_config     = $master::bootstrap_config,
  $service_stop_retries = $master::service_stop_retries,
  $start_timeout        = $master::start_timeout,
  $reload_timeout       = $master::reload_timeout,


) {

  file { $service_config_file:
    ensure  => $service_ensure ? {
      running => 'present',
      default => 'absent'
    },
    mode    => '0644',
    content => template('master/puppetserver-config.erb')
  }

  class { 'master::config::puppet':
    main   => {
      certname         => $master::certname,
      server           => $master::server,
      environment      => $master::environment,
      runinterval      => $master::runinterval,
      strict_variables => $master::strict_variables,
    },
    master => {
      'dns_alt_names' => $master::dns_alt_names.join(',')
    }
  }



}