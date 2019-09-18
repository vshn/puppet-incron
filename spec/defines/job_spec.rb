# frozen_string_literal: true

require 'spec_helper'

describe 'incron::job' do
  let(:title) { 'process_file' }

  context 'with minimal parameters' do
    let(:params) do
      {
        command: '/usr/bin/process_file',
        path:    '/upload',
        event:   'IN_MOVED_TO',
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('incron') }

    it { is_expected.not_to contain_file('/etc/incron.d/process_file') }

    it {
      is_expected.to contain_concat('/var/spool/incron/root')
        .with(
          ensure: :present,
          mode:   '0600',
          owner:  'root',
        )
    }

    it {
      is_expected.to contain_concat__fragment('incron_process_file')
        .with(
          target:  '/var/spool/incron/root',
          content: "/upload IN_MOVED_TO /usr/bin/process_file\n",
        )
    }
  end

  context 'with multiple incron events' do
    let(:params) do
      {
        command: '/usr/bin/process_file',
        path:    '/upload',
        event:   ['IN_MOVED_TO', 'IN_CLOSE_WRITE'],
      }
    end

    it {
      is_expected.to contain_concat__fragment('incron_process_file')
        .with_content(%r{/upload IN_MOVED_TO,IN_CLOSE_WRITE /usr/bin/process_file})
    }
  end
end
