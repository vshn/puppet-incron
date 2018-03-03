# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'incron' do
  managed_files = %w[
    /etc/incron.allow
    /etc/incron.deny
    /etc/incron.conf
    /etc/incron.d
  ]

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

    managed_files.each do |present_file|
      describe file(present_file) do
        it { is_expected.to exist }
      end
    end

    describe file('/etc/incron.d') do
      it { is_expected.to be_directory }
    end
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

    managed_files.each do |absent_file|
      describe file(absent_file) do
        it { is_expected.not_to exist }
      end
    end
  end
end
