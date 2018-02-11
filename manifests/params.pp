class logcheck::params (
  $reportlevel = 'server',
  $sendmailto  = 'logcheck',
  $logfiles    = [],
) {

  $package_name     = ['logcheck', 'logcheck-database']
  $config_file      = '/etc/logcheck/logcheck.conf'
  $logfiles_file    = '/etc/logcheck/logcheck.logfiles'
  $dbs_dir          = '/etc/logcheck'
  $user             = 'root'
  $group            = 'logcheck'

  case $::operatingsystem {
    ubuntu, debian: {
      $logfiles_default = [
        '/var/log/syslog',
        '/var/log/auth.log',
      ]
    }
    redhat, centos: {
      $logfiles_default = [
        '/var/log/messages',
        '/var/log/secure',
      ]
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }

  # Can't use a selector until http://projects.puppetlabs.com/issues/5860 is fixed
  #$logfiles_real = $logfiles ? {
  #  []      => $logfiles_default,
  #  default => $logfiles,
  #}
  if $logfiles == [] {
    $logfiles_real = $logfiles_default
  }
  else {
    $logfiles_real = $logfiles
  }

}
