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

    it {
      is_expected.to contain_file('/etc/incron.d/process_file')
        .only_with(
          ensure:  :file,
          owner:   'root',
          group:   'root',
          mode:    '0644',
          content: "/upload IN_MOVED_TO /usr/bin/process_file\n",
        )
        .without_content(/^#/) # Causes incron to spew tons of warnings in logs
    }
  end

  context 'with multiple incron events' do
    let(:params) do
      {
        command: '/usr/bin/process_file',
        path:    '/upload',
        event:   %w[IN_MOVED_TO IN_CLOSE_WRITE],
      }
    end

    it {
      is_expected.to contain_file('/etc/incron.d/process_file')
        .with_content(%r{/upload IN_MOVED_TO,IN_CLOSE_WRITE /usr/bin/process_file})
        .without_content(/^#/)
    }
  end
end
