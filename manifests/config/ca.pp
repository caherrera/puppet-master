class master::config::ca () {
  exec { 'puppetserver-ca-setup':
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/opt/puppetlabs/bin',
    command => 'puppetserver ca setup',

  }

}