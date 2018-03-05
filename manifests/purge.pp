# Purge `/etc/incron.d` directory.
#
# @api private
class incron::purge {

  file { '/etc/incron.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    purge   => true,
    force   => true,
    noop    => if $::incron::purge_noop { true } else { undef },
  }

}
