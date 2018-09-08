# frozen_string_literal: true

require 'beaker-puppet'
require 'beaker-rspec'
require 'beaker/module_install_helper'

install_puppet_from_gem_on(hosts, version: ENV.fetch('PUPPET', '~> 5.0'))
install_module_dependencies
install_module

RSpec.configure do |c|
  c.color     = true
  c.formatter = :documentation
end

# This runs the supplied manifest twice on the host.
#
# First time checking for failures.
# Second time checking for changes.
#
# Idempotent and clean. Just the way I like it.
def apply_and_test_idempotence(manifest)
  context 'applying manifest and testing for idempotence' do
    it 'does not fail the first time around' do
      apply_manifest(manifest, catch_failures: true)
    end

    it 'does not change anything on the second run' do
      apply_manifest(manifest, catch_changes: true)
    end
  end
end
