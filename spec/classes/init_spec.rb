require 'spec_helper'

describe 'incron' do
  context 'with default parameters' do
    it { is_expected.to contain_class('incron') }
  end
end