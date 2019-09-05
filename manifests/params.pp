# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include master::params
class master::params (
  ### START Package Configuration ###
  $package_ensure              = present,
  $package_name                = 'puppetserver',
  ### END Package Configuration ###

  ### START Service Configuation ###
  $service_ensure              = running,
  $service_enable              = true,
  $service_flags               = undef,
  $service_restart             = undef,
  $service_name                = 'puppetserver',
  $service_manage              = true,
  ### END Service Configuration ###

  $user                        = "puppet",
  $group                       = "puppet",
  $install_dir                 = "/opt/puppetlabs/server/apps/puppetserver",
  $config                      = "/etc/puppetlabs/puppetserver/conf.d",

  $tk_args                     = "",
  $java_args                   = ["-Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"],
  $bootstrap_config            = [    "/etc/puppetlabs/puppetserver/services.d/",
    "/opt/puppetlabs/server/apps/puppetserver/config/services.d/"  ],
  $service_stop_retries        = 60,
  $start_timeout               = 300,
  $reload_timeout              = 120,


  String $puppetconf           = '/etc/puppetlabs/puppet/puppet.conf',
  Array[String] $dns_alt_names = ['puppetmaster01', 'puppetmaster01.localdomain.com', 'puppet', 'puppet.example.com'],
  String $certname             = "${::hostname}.localdomain",
  String $server               = 'puppet',
  String $environment          = 'production',
  String $runinterval          = '1h',
  Boolean $strict_variables    = false,


) {
  $t = $facts['memory']['system']['total_bytes']
  if $t < 1050904576 {
    $memory_allocation = 0
  }else {
    $memory_allocation = master::mallocation($t)
  }

  case $::osfamily {
    'debian': {
      $service_config_file = '/etc/default/puppetserver'
      $java_bin = '/usr/bin/java'
    }
    'redhat': {
      $service_config_file = '/etc/sysconfig/puppetserver'
      $java_bin = '/usr/bin/java'
    }
    default: { abort('OS Family is not allowed') } # apply the generic class

  }

}
