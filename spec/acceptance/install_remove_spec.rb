# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'incron' do
  context 'installs?' do
    pp = <<~PUPPET

      include incron

    PUPPET

    apply_and_test_idempotence(pp)

    describe package('incron') do
      it { is_expected.to be_installed }
    end

    describe service('incron') do
      it { is_expected.to be_running }
    end

    describe file('/etc/incron.allow') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match('') }
    end

    describe file('/etc/incron.conf') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match('') }
    end

    describe file('/etc/incron.d') do
      it { is_expected.to exist }
      it { is_expected.to be_directory }
    end

    describe file('/etc/incron.deny') { it { is_expected.not_to exist } }
  end

  context 'removes?' do
    pp = <<~PUPPET
      class { 'incron':
        ensure => absent
      }
    PUPPET

    apply_and_test_idempotence(pp)

    describe package('incron') do
      it { is_expected.not_to be_installed }
    end

    describe service('incron') do
      it { is_expected.not_to be_running }
    end

    managed_files = %w[
      /etc/incron.allow
      /etc/incron.deny
      /etc/incron.conf
      /etc/incron.d
    ]

    managed_files.each do |absent_file|
      describe file(absent_file) do
        it { is_expected.not_to exist }
      end
    end
  end
end
