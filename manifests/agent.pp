# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include master::agent
class master::agent (

) inherits master::params {

  class { master::config::puppet:
    agent => true
  }

  class { master::service:
    service_name => 'puppet'
  }

  Class['master::config::puppet'] ~> Class['master::service']

}
