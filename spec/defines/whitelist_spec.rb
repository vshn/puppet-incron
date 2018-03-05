# frozen_string_literal: true

require 'spec_helper'

describe 'incron::whitelist' do
  context 'without any parameters' do
    let(:title) { 'whitelisted' }

    it {
      is_expected.to contain_file('/etc/incron.d/whitelisted').only_with(
        ensure:  :file,
        replace: false,
      )
    }
  end
end
