source 'https://rubygems.org'

puppet_version = ENV.fetch('PUPPET', '~> 5')

group :documentation do
  gem 'puppet-strings'
end

group :unit do
  gem 'puppet', puppet_version
  gem 'puppetlabs_spec_helper'
end

group :validate do
  gem 'metadata-json-lint'
  gem 'puppet-lint'
  gem 'rubocop-rspec'
  gem 'sem_version'
  gem 'semantic_puppet'
  gem 'yamllint'
end
