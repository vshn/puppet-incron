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

    present_files = %w[
      /etc/incron.allow
      /etc/incron.deny
      /etc/incron.conf
    ]

    present_files.each do |present_file|
      describe file(present_file) do
        it { is_expected.to exist }
      end
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

    absent_files = %w[
      /etc/incron.allow
      /etc/incron.deny
      /etc/incron.conf
    ]

    absent_files.each do |absent_file|
      describe file(absent_file) do
        it { is_expected.not_to exist }
      end
    end
  end
end
