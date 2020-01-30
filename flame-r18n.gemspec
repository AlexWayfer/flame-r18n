# frozen_string_literal: true

require 'date'

Gem::Specification.new do |s|
	s.name        = 'flame-r18n'
	s.version     = '2.3.1'
	s.date        = Date.today.to_s

	s.summary     = 'R18n plugin for Flame-framework'
	s.description = 'Flame extension which provides i18n support' \
	                ' to translate your web application.' \
	                ' It is a wrapper for R18n core library.' \
	                ' See R18n documentation for more information.'

	s.authors     = ['Alexander Popov']
	s.email       = ['alex.wayfer@gmail.com']
	s.homepage    = 'https://github.com/AlexWayfer/flame-r18n'
	s.license     = 'MIT'

	s.add_dependency 'flame', '>= 5.0.0.rc3', '< 6'
	s.add_dependency 'r18n-core', '~> 4.0'

	s.add_development_dependency 'codecov', '~> 0.1.16'
	s.add_development_dependency 'minitest', '~> 5.10'
	s.add_development_dependency 'minitest-reporters', '~> 1.1'
	s.add_development_dependency 'pry-byebug', '~> 3.5'
	s.add_development_dependency 'rack-test', '~> 1.0'
	s.add_development_dependency 'rake', '~> 13.0'
	s.add_development_dependency 'rubocop', '~> 0.79.0'
	s.add_development_dependency 'simplecov', '~> 0.18.0'

	s.files = Dir[File.join('lib', '**', '*')]
end
