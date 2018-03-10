# This class handles incron configuration files.
#
# @api private
class incron::config {

  if !empty($::incron::allowed_users) and !empty($::incron::denied_users) {
    fail('Either allowed or denied incron users must be specified, not both.')
  }

  file {
    default:
      force => true,
      owner => 'root',
      group => 'root',
      mode  => '0644';
    '/etc/incron.conf':
      ensure  => file,
      content => '';
    '/etc/incron.allow':
      ensure  => if empty($::incron::denied_users) { file } else { absent },
      content => join(suffix($::incron::allowed_users, "\n"));
    '/etc/incron.deny':
      ensure  => unless empty($::incron::denied_users) { file } else { absent },
      content => join(suffix($::incron::denied_users, "\n"));
  }

}
