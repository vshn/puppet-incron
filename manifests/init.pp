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
# @param allowed_users List of users allowed to use incron. By default, only root can.
# @param denied_users List of users denied to use incron.
class incron (
  Enum[present, absent] $ensure        = present,
  Boolean               $purge_noop    = false,
  Array[String[1]]      $allowed_users = [ ],
  Array[String[1]]      $denied_users  = [ ],
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
