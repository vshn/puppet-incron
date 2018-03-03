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
# @param dir_mode Permissions for /etc/incron.d directory.
class incron (
  Enum[present, absent]   $ensure   = present,
  Pattern[/^07[057]{2}$/] $dir_mode = '0755',
) {

  if $ensure == present {

    contain incron::install
    contain incron::config
    contain incron::service

    Class['::incron::install']
    -> Class['::incron::config']
    ~> Class['::incron::service']

  } else {

    contain incron::remove

  }

}
