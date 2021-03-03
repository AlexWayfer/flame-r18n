# frozen_string_literal: true

Gem::Specification.new do |spec|
	spec.name        = 'flame-r18n'
	spec.version     = '2.3.1'

	spec.summary     = 'R18n plugin for Flame-framework'
	spec.description = <<~DESC
		Flame extension which provides i18n support to translate
		your web application. It is a wrapper for R18n core library.
		See R18n documentation for more information.
	DESC

	spec.authors     = ['Alexander Popov']
	spec.email       = ['alex.wayfer@gmail.com']
	spec.license     = 'MIT'

	source_code_uri = 'https://github.com/AlexWayfer/flame-r18n'

	spec.homepage = source_code_uri

	spec.metadata['source_code_uri'] = source_code_uri

	spec.metadata['homepage_uri'] = spec.homepage

	spec.metadata['changelog_uri'] =
		'https://github.com/AlexWayfer/flame-r18n/blob/master/CHANGELOG.md'

	spec.files = Dir['lib/**/*.rb', 'README.md', 'LICENSE.txt', 'CHANGELOG.md']

	spec.required_ruby_version = '>= 2.5'

	spec.add_dependency 'flame', '>= 5.0.0.rc3', '< 6'
	spec.add_dependency 'r18n-core', '~> 5.0'

	spec.add_development_dependency 'pry-byebug', '~> 3.9'

	spec.add_development_dependency 'bundler', '~> 2.0'
	spec.add_development_dependency 'gem_toys', '~> 0.5.0'
	spec.add_development_dependency 'toys', '~> 0.11.0'

	spec.add_development_dependency 'codecov', '~> 0.2.1'
	spec.add_development_dependency 'rack-test', '~> 1.0'
	spec.add_development_dependency 'rspec', '~> 3.9'
	spec.add_development_dependency 'simplecov', '~> 0.20.0'

	spec.add_development_dependency 'rubocop', '~> 1.3'
	spec.add_development_dependency 'rubocop-performance', '~> 1.0'
	spec.add_development_dependency 'rubocop-rspec', '~> 2.0'
end
