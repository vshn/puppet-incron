# @api private
# This class handles incron service.
# Avoid modifying and using private classes directly.
class incron::service {

  service { 'incron':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => false,
  }

}