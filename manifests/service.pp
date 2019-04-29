# Class: master::service
#
# This module manages NGINX service management and server rebuild
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
class master::service(
  $service_restart = $master::service_restart,
  $service_ensure  = $master::service_ensure,
  $service_enable  = $master::service_enable,
  $service_name    = $master::service_name,
  $service_flags   = $master::service_flags,
  $service_manage  = $master::service_manage,
) {

  assert_private()

  if $service_manage {
    case $facts['os']['name'] {
      default: {
        service { $service_name:
          ensure     => $service_ensure,
          enable     => $service_enable,
          hasstatus  => true,
          hasrestart => true,
        }
      }
    }
  }

  # Allow overriding of 'restart' of Service resource; not used by default
  if $service_restart {
    Service[$service_name] {
      restart => $service_restart,
    }
  }
}
