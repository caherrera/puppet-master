# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include master
class master (
  ### START Package Configuration ###
  $package_ensure               = $master::params::package_ensure,
  $package_name                 = $master::params::package_name,
  ### END Package Configuration ###

  ### START Service Configuation ###
  $service_ensure               = $master::params::service_ensure,
  $service_enable               = $master::params::service_enable,
  $service_flags                = $master::params::service_flags,
  $service_restart              = $master::params::service_restart,
  $service_name                 = $master::params::service_name,
  $service_manage               = $master::params::service_manage,
  ### END Service Configuration ###

  String $java_bin              = $master::params::java_bin,
  String $memory_allocation     = $master::params::memory_allocation,
  String $tk_args               = $master::params::tk_args,
  Tuple $java_args              = $master::params::java_args,
  Tuple $bootstrap_config       = $master::params::bootstrap_config,
  Numeric $service_stop_retries = $master::params::service_stop_retries,
  Numeric $start_timeout        = $master::params::start_timeout,
  Numeric $reload_timeout       = $master::params::reload_timeout,


) inherits master::params {

  if $memory_allocation !~ /[1-9]{1,3}[mg]/ {
    $memory_size = regsubst($memory_allocation, /(\d+)([mg])/, '\1')
    $memory_in_megabytes = regsubst($memory_allocation, /(\d+)([mg])/, '\2') ? {
      'm' => $memory_size,
      'g' => $memory_size * 1024
    }

    if $memory_in_megabytes < 512 {
      fail('Not enough available RAM. Minimun for puppet is 512MB')
    }

  }
  contain 'master::install'
  contain 'master::config'
  contain 'master::service'

}
