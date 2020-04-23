# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include master::install
class master::install {

  case $::osfamily {
    'debian': {
      case $::operatingsystemmajrelease {
        '8': {
          class { 'apt': }
          apt::backports { 'jessie-backports':
            location => 'http://ftp.debian.org/debian',
            release  => 'jessie-backports',
            repos    => 'main',

          }
          Class['apt'] -> Class['java']
        }
      default:{}
      }
    }
    'ubuntu': {
      notice('Instaling to ubuntu\'s family')
    }
    'RedHat': {
      notice('Instaling to ubuntu\'s family')
    }
    default: { fail("OS Family is not allowed ${::osfamily}") } # apply the generic class


  }

  class { 'java': } -> package { 'puppetserver': ensure => present }


}
