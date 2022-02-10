# logcheck::ignore
#
# This class handles the module data
#
define logcheck::ignore (
  $rule,
  $ensure   = $logcheck::ensure,
  $level    = $logcheck::params::reportlevel,
  $type     = 'ignore',
  $filename = $name,
) {

  require logcheck::params

  case $type {
    'ignore': {
      $file = "/etc/logcheck/ignore.d.${level}/${filename}"
    }
    'violations','cracking': {
      $file = "/etc/logcheck/${type}.ignore.d/${filename}"
    }
    default: {
      fail "Uknown type ${type} for logcheck::ignore"
    }
  }

  file { $file :
    ensure  => $ensure,
    owner   => $logcheck::params::user,
    group   => $logcheck::params::group,
    content => "${rule}\n",
    mode    => '0640',
  }
}
