require 'spec_helper_acceptance'

describe 'incron' do
  context 'installs?' do
    pp = <<~PUPPET

      include incron

    PUPPET

    context 'idempotence' do
      it 'does not fail the first time around' do
        apply_manifest(pp, catch_failures: true)
      end

      it 'does not change anything on the second run' do
        apply_manifest(pp, catch_changes: true)
      end
    end

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

    context 'idempotence' do
      it 'does not fail the first time around' do
        apply_manifest(pp, catch_failures: true)
      end

      it 'does not change anything on the second run' do
        apply_manifest(pp, catch_changes: true)
      end
    end

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
