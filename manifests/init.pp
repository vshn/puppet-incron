# Main entry point for incron class which must be included
# in order to start managing all incron-related resources.
#
# @example Installing incron
#   include incron
#
# @example Uninstalling incron and all related resources
#   class { 'incron':
#     ensure => absent,
#   }
#
# @param ensure Whether to enable or disable incron on the system.
# @param purge_noop Run purging in `noop` mode.
class incron (
  Enum[present, absent] $ensure     = present,
  Boolean               $purge_noop = false,
) {

  if $ensure == present {

    contain incron::install
    contain incron::config
    contain incron::service

    contain incron::purge

    Class['::incron::install'] -> Class['::incron::config'] -> Class['::incron::purge']
    Class['::incron::install'] ~> Class['::incron::service']
    Class['::incron::config'] ~> Class['::incron::service']

  } else {

    contain incron::remove

  }

}
