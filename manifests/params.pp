class logcheck::params (
  $reportlevel = 'server',
  $sendmailto  = 'logcheck',
  $logfiles    = [],
) {

  case $::operatingsystem {
    ubuntu, debian: {
      $package_name     = 'logcheck'
      $config_file      = '/etc/logcheck/logcheck.conf'
      $logfiles_file    = '/etc/logcheck/logcheck.logfiles'
      $dbs_dir          = '/etc/logcheck'
      $user             = 'root'
      $group            = 'logcheck'
      $logfiles_default = [
        '/var/log/syslog',
        '/var/log/auth.log',
      ]
    }
#    redhat, centos: {
#      $package_name    = 'logcheck'
#    }
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
