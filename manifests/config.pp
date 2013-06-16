class logcheck::config () {
  require logcheck::params
  require logcheck::install

  file { $logcheck::params::config_file :
    ensure  => $logcheck::ensure,
    owner   => $logcheck::params::user,
    group   => $logcheck::params::group,
    mode    => '0640',
    content => template('logcheck/logcheck.conf.erb'),
  }

  file { $logcheck::params::logfiles_file :
    ensure  => $logcheck::ensure,
    owner   => $logcheck::params::user,
    group   => $logcheck::params::group,
    content => template('logcheck/logcheck.logfiles.erb'),
    mode    => '0640',
  }

  $defaults = {
    tag => $::fqdn,
  }

  create_resources(
    logcheck::ignore,
    hiera_hash('logcheck::ignores', {}),
    $defaults
  )

  Logcheck::Ignore <| tag == $::fqdn |>
  Logcheck::Ignore <<| tag == $::fqdn |>>

}
