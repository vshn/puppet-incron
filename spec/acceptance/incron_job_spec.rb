# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'incron::job' do
  context 'creates incron::job' do
    pp = <<~PUPPET

      file { '/usr/bin/test_notify':
        ensure  => file,
        mode    => '0775',
        owner   => 'root',
        group   => 'root',
        content => '#!/bin/bash
      echo $1 >> /tmp/notify',
      }

      file { '/watched_directory':
        ensure => directory,
        mode   => '0777',
        owner  => 'root',
        group  => 'root',
      }

      include incron

      incron::job { 'notify_me_please':
        path    => '/watched_directory',
        event   => 'IN_CLOSE_WRITE',
        command => '/usr/bin/test_notify $#',
      }

    PUPPET

    apply_and_test_idempotence pp
  end

  context 'incron job works' do
    describe command('echo hello > /watched_directory/notify_about_me_pretty_plz') do
      its(:exit_status) { is_expected.to eq 0 }
    end

    describe file('/tmp/notify') do
      it { is_expected.to be_file }
      its(:content) { is_expected.to match(/^notify_about_me_pretty_plz$/) }
    end
  end

  context 'clean up after myself' do
    pp = <<~PUPPET

      file {
        [
          '/usr/bin/test_notify',
          '/watched_directory',
          '/tmp/notify',
        ]:
          ensure  => absent,
          recurse => true,
          force   => true,
      }

      include incron

    PUPPET

    apply_and_test_idempotence pp

    cleaned_up_files = ['/usr/bin/test_notify', '/watched_directory', '/tmp/notify', '/etc/incron.d/notify_me_please']

    cleaned_up_files.each do |cleaned_up_file|
      describe file(cleaned_up_file) do
        it { is_expected.not_to exist }
      end
    end
  end
end
