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
# @param user User that owns incron job
define incron::job (
  String[1]                  $command,
  Variant[Incron::Event,
    Array[Incron::Event, 2]] $event,
  Stdlib::Unixpath           $path,
  String[1]                  $user = 'root',
) {

  include ::incron

  if !defined(Concat["/var/spool/incron/${user}"]) {
    concat { "/var/spool/incron/${user}":
      ensure => present,
      mode   => '0600',
      owner  => $user,
      group  => 'incron',
    }
  }

  concat::fragment { "incron_${title}":
    target  => "/var/spool/incron/${user}",
    content => "${path} ${join(any2array($event), ',')} ${command}\n",
  }

}
