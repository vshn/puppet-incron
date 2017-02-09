# incron::whitelist resource
#
# Use it to whitelist any system incron jobs you don't want to touch.
#
# @author Eugene Piven <epiven@gmail.com>
#
# @example Using incron::whitelist resource
#   incron::whitelist { 'uploader': }
define incron::whitelist {

  require ::incron

  file { "/etc/incron.d/${name}":
    ensure  => file,
    replace => false,
  }

}