# Primary incron resource used to create incron jobs.
#
# @example Using incron::job resource
#   incron::job { 'process_file':
#     path    => '/upload',
#     event   => 'IN_CLOSE_WRITE',
#     command => '/usr/bin/process_file $#',
#   }
#
# @param command Command to execute on triggered event
# @param event inotify event (or an array of events)
# @param path Path to watched directory
# @param mode Incron job file permissions, which is located at `/etc/incron.d/${name}`
define incron::job (
  String                     $command,
  Variant[Incron::Event,
    Array[Incron::Event, 2]] $event,
  Stdlib::Unixpath           $path,
  Pattern[/^0[46][046]{2}$/] $mode = '0644',
) {

  include ::incron

  file { "/etc/incron.d/${name}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => $mode,
    content => epp("${module_name}/job.epp", {
      command => $command,
      event   => $event,
      path    => $path,
    }),
  }

}
