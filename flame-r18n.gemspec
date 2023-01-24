# frozen_string_literal: true

require_relative 'lib/flame/r18n/version'

Gem::Specification.new do |spec|
	spec.name        = 'flame-r18n'
	spec.version     = Flame::R18n::VERSION

	spec.summary     = 'Flame plugin which provides i18n and L10n support'
	spec.description = <<~DESC
		Flame plugin which provides i18n and L10n support to your web application.
		It is a wrapper for R18n core library. See R18n documentation for more information.
	DESC

	spec.authors     = ['Alexander Popov']
	spec.email       = ['alex.wayfer@gmail.com']
	spec.license     = 'MIT'

	source_code_uri = 'https://github.com/AlexWayfer/flame-r18n'

	spec.homepage = source_code_uri

	spec.metadata['source_code_uri'] = source_code_uri

	spec.metadata['homepage_uri'] = spec.homepage

	spec.metadata['changelog_uri'] =
		'https://github.com/AlexWayfer/flame-r18n/blob/main/CHANGELOG.md'

	spec.metadata['rubygems_mfa_required'] = 'true'

	spec.files = Dir['lib/**/*.rb', 'README.md', 'LICENSE.txt', 'CHANGELOG.md']

	spec.required_ruby_version = '>= 2.6'

	spec.add_dependency 'flame', '>= 5.0.0.rc3', '< 6'
	spec.add_dependency 'r18n-core', '~> 5.0'

	spec.add_development_dependency 'pry-byebug', '~> 3.9'

	spec.add_development_dependency 'bundler', '~> 2.0'
	spec.add_development_dependency 'gem_toys', '~> 0.12.1'
	spec.add_development_dependency 'toys', '~> 0.14.2'

	spec.add_development_dependency 'rack-test', '~> 2.0'
	spec.add_development_dependency 'rspec', '~> 3.9'
	spec.add_development_dependency 'simplecov', '~> 0.22.0'
	spec.add_development_dependency 'simplecov-cobertura', '~> 2.1'

	spec.add_development_dependency 'rubocop', '~> 1.44.0'
	spec.add_development_dependency 'rubocop-performance', '~> 1.0'
	spec.add_development_dependency 'rubocop-rspec', '~> 2.0'
end
