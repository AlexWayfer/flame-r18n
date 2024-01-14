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

	spec.required_ruby_version = '>= 3.0', '< 4'

	spec.add_dependency 'flame', '>= 5.0.0.rc3', '< 6'
	spec.add_dependency 'r18n-core', '~> 5.0'
end
