# frozen_string_literal: true

require 'spec_helper'

describe 'incron' do
  context 'with default parameters' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('incron') }

    it { is_expected.to contain_class('incron::install') }
    it { is_expected.to contain_class('incron::config') }
    it { is_expected.to contain_class('incron::service') }

    describe 'incron::install' do
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_package('incron').with_ensure(:installed) }
    end

    describe 'incron::config' do
      it { is_expected.to compile.with_all_deps }
      it {
        is_expected.to contain_file('/etc/incron.conf').only_with(
          ensure:  :file,
          content: '',
          owner:   'root',
          group:   'root',
          mode:    '0644',
        )
      }
      it {
        is_expected.to contain_file('/etc/incron.allow').only_with(
          ensure:  :file,
          content: '',
          owner:   'root',
          group:   'root',
          mode:    '0640',
        )
      }
      it {
        is_expected.to contain_file('/etc/incron.deny').only_with(
          ensure:  :file,
          content: '',
          owner:   'root',
          group:   'root',
          mode:    '0640',
        )
      }
      it {
        is_expected.to contain_file('/etc/incron.d').only_with(
          ensure:  :directory,
          recurse: true,
          purge:   true,
          force:   true,
          owner:   'root',
          group:   'root',
          mode:    '0755',
        )
      }
    end

    describe 'incron::service' do
      it { is_expected.to compile.with_all_deps }
      it {
        is_expected.to contain_service('incron').only_with(
          ensure:     :running,
          enable:     true,
          hasrestart: true,
          hasstatus:  false,
        )
      }
    end
  end

  context 'with custom dir_mode' do
    let(:params) { { dir_mode: '0700' } }

    it { is_expected.to compile.with_all_deps }
    it {
      is_expected.to contain_file('/etc/incron.d').only_with(
        ensure:  :directory,
        recurse: true,
        purge:   true,
        force:   true,
        owner:   'root',
        group:   'root',
        mode:    '0700',
      )
    }
  end

  context 'with ensure => absent' do
    let(:facts) { { os: { release: { full: '14.04' } } } }
    let(:params) { { ensure: 'absent' } }

    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('incron::remove') }

    it { is_expected.not_to contain_class('incron::install') }
    it { is_expected.not_to contain_class('incron::config') }
    it { is_expected.not_to contain_class('incron::service') }

    context 'incron::remove' do
      it { is_expected.to contain_package('incron').with_ensure(:purged) }
      it {
        is_expected.to contain_file('/etc/incron.d').with(
          ensure: :absent,
          force:  true,
        )
      }
      it { is_expected.to contain_file('/etc/incron.conf').with_ensure(:absent) }
      it { is_expected.to contain_file('/etc/incron.allow').with_ensure(:absent) }
      it { is_expected.to contain_file('/etc/incron.deny').with_ensure(:absent) }

      # FIXME
      # rspec-puppet-facts `on_supported_os` doesn't do 18.04 yet
      %w[14.04 16.04 18.04].each do |os_ver|
        context "on Ubuntu #{os_ver}" do
          let(:facts) { { os: { release: { full: os_ver } } } }

          if os_ver == '14.04'
            it { is_expected.not_to contain_service('incron') }
          else
            it { is_expected.to contain_service('incron').with_ensure(:stopped).with_provider(:systemd) }
          end
        end
      end
    end
  end
end
