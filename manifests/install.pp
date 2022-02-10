# logcheck::install
#
# This class is responsible for installing the logcheck package
#
class logcheck::install () {

  require logcheck::params

  package { $logcheck::params::package_name:
    ensure  => $logcheck::package_ensure,
  }

}
