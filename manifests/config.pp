# This class handles incron configuration files.
#
# @api private
class incron::config {

  if !empty($::incron::allowed_users) and !empty($::incron::denied_users) {
    fail('Either allowed or denied incron users must be specified, not both.')
  }

  file { '/etc/incron.deny':
    ensure  => unless empty($::incron::denied_users) { file } else { absent },
    force   => true,
    content => join(suffix($::incron::denied_users, "\n")),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  }

  file { '/etc/incron.allow':
    ensure  => if empty($::incron::denied_users) { file } else { absent },
    force   => true,
    content => join(suffix($::incron::allowed_users, "\n")),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  }

  file { '/etc/incron.conf':
    ensure  => file,
    force   => true,
    content => '',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  }

}
