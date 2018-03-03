# Use this to whitelist any system incron jobs you don't want to touch.
# This will make sure that `/etc/incron.d/${title}` won't get deleted
# nor modified.
#
# @example Using incron::whitelist resource
#   incron::whitelist { 'uploader': }
define incron::whitelist {

  include ::incron

  file { "/etc/incron.d/${name}":
    ensure  => file,
    replace => false,
  }

}
