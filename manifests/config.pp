# This class handles incron configuration files.
#
# @api private
class incron::config {

  file { [ '/etc/incron.allow', '/etc/incron.deny' ]:
    ensure  => file,
    content => '',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  }

  file { '/etc/incron.conf':
    ensure  => file,
    content => '',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

}
