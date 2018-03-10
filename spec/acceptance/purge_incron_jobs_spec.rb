# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'incron::purge' do
  context 'manage two incron jobs' do
    pp = <<~PUPPET

      include incron

      incron::job { 'job_one':
        path    => '/nonexistant',
        event   => 'IN_MOVED_TO',
        command => '/bin/echo',
      }

      incron::job { 'job_two':
        path    => '/nonexistant',
        event   => 'IN_MOVED_TO',
        command => '/bin/echo',
      }

    PUPPET

    apply_and_test_idempotence(pp)

    describe file('/etc/incron.d/job_one') do
      it { is_expected.to exist }
    end
    describe file('/etc/incron.d/job_two') do
      it { is_expected.to exist }
    end
  end

  context 'manage only one incron job' do
    pp = <<~PUPPET

      include incron

      incron::job { 'job_one':
        path    => '/nonexistant',
        event   => 'IN_MOVED_TO',
        command => '/bin/echo',
      }

    PUPPET

    apply_and_test_idempotence(pp)

    describe file('/etc/incron.d/job_one') do
      it { is_expected.to exist }
    end
    describe file('/etc/incron.d/job_two') do
      it { is_expected.not_to exist }
    end
  end
end
