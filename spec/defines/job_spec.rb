require 'spec_helper'

describe 'incron::job' do
  let(:title) { 'process_file' }

  context 'with minimal parameters' do
    let(:params) { {
      command: '/usr/bin/process_file',
      path:    '/upload',
      event:   'IN_MOVED_TO',
    } }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('incron') }

    it { is_expected.to contain_file('/etc/incron.d/process_file').with(
      owner:   'root',
      group:   'root',
      mode:    '0644',
      content: /^\/upload IN_MOVED_TO \/usr\/bin\/process_file$/,
    ) }

  end
end