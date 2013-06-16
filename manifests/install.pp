class logcheck::install () {

  require logcheck::params

  package { $logcheck::params::package_name:
    ensure  => $logcheck::package_ensure,
  }

}
