# This class handles incron service.
#
# @api private
class incron::service {

  service { 'incron':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => false,
  }

}
