# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'incron' do
  context 'installs?' do
    pp = <<~PUPPET

      include incron

    PUPPET

    apply_and_test_idempotence(pp)

    # Installs and runs
    describe package('incron') { it { is_expected.to be_installed } }
    describe service('incron') { it { is_expected.to be_running } }
    describe file('/etc/incron.d') { it { is_expected.to be_directory } }
  end

  context 'removes?' do
    pp = <<~PUPPET
      class { 'incron':
        ensure => absent
      }
    PUPPET

    apply_and_test_idempotence(pp)

    # Uninstalls and cleans up
    describe package('incron') { it { is_expected.not_to be_installed } }
    describe service('incron') { it { is_expected.not_to be_running } }
    %w[
      /etc/incron.allow
      /etc/incron.deny
      /etc/incron.conf
      /etc/incron.d
    ].each do |absent_file|
      describe file(absent_file) { it { is_expected.not_to exist } }
    end
  end
end
