# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include master::agent
class master::agent (
  Boolean $agent = false,
  Hash $main     = {},
  Hash $master   = {},
) inherits master::params {

  class { master::config::puppet:
    agent  => true,
    master => $master,
    main   => $main,
  }
~>
  class { master::service:

    service_name    => 'puppet',
    service_restart => $master::params::service_restart,
    service_ensure  => $master::params::service_ensure,
    service_enable  => $master::params::service_enable,
    service_flags   => $master::params::service_flags,
    service_manage  => $master::params::service_manage,


  }

}
