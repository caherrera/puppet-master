define master::config::add (
  String $config_file = $master::config::conf::config_file,
  String $content     = undef,
  String $order       = '20'

) {
  include master::config::conf

  concat::fragment { "puppet_conf_$name":
    target  => $config_file,
    content => $content,
    order   => $order,
  }
}