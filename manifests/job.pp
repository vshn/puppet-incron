# incron::job class
#
# Primary incron resource used to create incron jobs.
#
# @author Eugene Piven <epiven@gmail.com>
#
# @see https://github.com/pegasd/puppet-incron
#
# @example Using incron resource
#   incron::job { 'process_file':
#     path    => '/upload',
#     event   => 'IN_CLOSE_WRITE',
#     command => '/usr/bin/process_file',
#   }
#
# @param command Command to execute on triggered event
# @param event inotify event (either 'IN_CLOSE_WRITE' or 'IN_MOVED_TO')
# @param path Path to watched directory
# @param mode Incron job file permissions, which is located at /etc/incron.d/JOB_NAME
define incron::job (
  String                                $command,
  Enum['IN_CLOSE_WRITE', 'IN_MOVED_TO'] $event,
  Stdlib::Unixpath                      $path,
  Pattern[/^[0-7]{4}$/]                 $mode = '0644',
) {

  require ::incron

  file { "/etc/incron.d/${name}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => $mode,
    content => epp("${module_name}/job.epp", {
      job_name => $name,
      command  => $command,
      event    => $event,
      path     => $path,
    })
  }

}
