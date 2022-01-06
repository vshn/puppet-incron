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
# @param ensure
#   Whether to enable or disable incron on the system.
#
# @param package_version
#   Provide custom `incron` package version here.
#
# @param allowed_users
#   List of users allowed to use `incrontab(1)`. `root` will be added automatically.
#
# @param denied_users
#   List of users specifically denied to use `incrontab(1)`.
#   Note: When this is not empty, all users except ones specified here will be able to use `incrontab`.
#
# @param service_name
#   Incron service's name.
#
# @param service_manage
#   Whether to manage incron service at all.
#
# @param service_ensure
#   Incron service's 'ensure' parameter.
#
# @param service_enable
#   Incron service's 'enable' parameter.
#
# @param purge_noop
#   Run purging in `noop` mode.
class incron (
  Enum[present, absent]  $ensure          = present,

  # incron::install
  String[1]              $package_version = installed,

  # incron::config
  Array[String[1]]       $allowed_users   = [ ],
  Array[String[1]]       $denied_users    = [ ],

  # incron::service
  String[1]              $service_name    = 'incrond',
  Boolean                $service_manage  = true,
  Enum[running, stopped] $service_ensure  = running,
  Boolean                $service_enable  = true,

  # incron::purge
  Boolean                $purge_noop      = false,
  # incron create from hash
  Hash                   $jobs            = {},
) {

  if $ensure == present {

    contain incron::install
    contain incron::config
    contain incron::service
    contain incron::purge

    Class['::incron::install'] -> Class['::incron::config'] -> Class['::incron::purge']
    Class['::incron::install'] ~> Class['::incron::service']
    Class['::incron::config'] ~> Class['::incron::service']
  
    create_resources('::incron::job', $jobs)
  } else {
    contain incron::remove
  }
}
