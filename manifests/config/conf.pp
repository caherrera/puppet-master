# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include master::conf
class master::config::conf (
  Variant[String, Undef] $conf = undef
) inherits master::params {

  Class[master::config::conf] -> Master::Config::Add<| |>

  $config_file = pick($conf, $master::params::puppetconf)

  concat { $config_file:
    mode           => '0644',
    ensure_newline => true
  }

  concat::fragment { "puppet_conf_signature":
    target  => $config_file,
    content => '### FILE MANAGED BY PUPPET ###',
    order   => '00',
  }
}
