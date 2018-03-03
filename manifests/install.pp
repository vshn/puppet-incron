# This class handles incron package.
#
# @api private
class incron::install {

  package { 'incron':
    ensure => installed,
  }

}
