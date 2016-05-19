Gem::Specification.new do |s|
	s.name        = 'flame-r18n'
	s.version     = '1.0.1'
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

	s.add_dependency 'flame', '~> 4.0', '>= 4.0.0'
	s.add_dependency 'r18n-core', '~> 2'

	s.files = Dir[File.join('lib', '**', '*')]
end
