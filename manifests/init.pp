# incron class
#
# Main entry point for incron class which must be included
# in order to start managing all incron-related resources.
#
# @author Eugene Piven <epiven@gmail.com>
#
# @see https://github.com/pegasd/puppet-cron
#
# @example Declaring incron
#   require incron
class incron (
  Enum[present, absent]   $ensure   = present,
  Pattern[/^06[046]{2}$/] $dir_mode = '0644',
) {

  contain incron::install
  contain incron::config
  contain incron::service

  Class['::incron::install'] ->
  Class['::incron::config'] ~>
  Class['::incron::service']

}