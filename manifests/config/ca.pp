class master::config::ca () {

  $ca_folder = '/etc/puppetlabs/puppet/ssl'

  exec { 'puppetserver-ca-setup':

    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/opt/puppetlabs/bin',
    command => "rm -rf * && /opt/puppetlabs/bin/puppetserver ca setup",
    cwd     => $ca_folder

  }

}