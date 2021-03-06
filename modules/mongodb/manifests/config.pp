class mongodb::config inherits mongodb::params {
  Exec {
    path      => "${::path}",
    logoutput => on_failure,
  }
  $db_path = $mongodb::db_path
  $port = $mongodb::port
  $log_file = $mongodb::log_file
  $replica_set = $mongodb::replica_set ? {
    'nil'   => false,
    default => $mongodb::replica_set,
  }
  $auth_enabled = $mongodb::params::auth_enabled ? {
    'true'  => true,
    default => false,
  }
  $iptables_hosts = $mongodb::params::iptables_hosts
  if ! defined(File['/etc/mongodb.conf']) {
    file { '/etc/mongodb.conf':
      alias   => 'mongodb::config::mongodb_conf',
      ensure  => present,
      content => template('mongodb/mongodb.conf.erb'),
      owner   => root,
      group   => root,
      mode    => 0644,
      notify  => Service['mongodb'],
    }
  }
  file { '/tmp/.arcus.iptables.rules.mongodb':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0600,
    content => template('mongodb/iptables.erb'),
  }
}
