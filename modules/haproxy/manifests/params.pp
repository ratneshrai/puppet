class haproxy::params {
  $iptables_hosts = hiera_array('haproxy_iptables_hosts', ['0.0.0.0/0'])
}
