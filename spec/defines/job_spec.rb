require 'spec_helper'

describe 'incron::job' do
  let(:title) { 'process_file' }

  context 'with minimal parameters' do
    let(:params) { {
      :command => '/usr/bin/process_file',
      :path    => '/upload',
      :event   => 'IN_CLOSE_WRITE',
    } }

    it { is_expected.to compile.with_all_deps }
  end
end