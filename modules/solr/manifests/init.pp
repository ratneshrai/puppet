# == Class: solr
#
# Installs and configures solr
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { solr: }
#    or
#  include solr
#
# === Authors
#
# Arcus <support@arcus.io>
#
# === Copyright
#
# Copyright 2013 Arcus, unless otherwise noted.
#
class solr (
    $configure=$solr::params::configure,
    $solr_url=$solr::params::solr_url,
  ) inherits solr::params {
  class { 'solr::package': }
  class { 'solr::config':
    require   => Class['solr::package'],
  }
  class { 'solr::service':
    require => [ Class['solr::config'], Class['solr::package'] ],
  }
}
