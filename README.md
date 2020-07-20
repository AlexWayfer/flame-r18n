# Flame R18n

[R18n](https://github.com/ai/r18n) helper for
[Flame](https://github.com/AlexWayfer/flame) applications.

[![Cirrus CI - Base Branch Build Status](https://img.shields.io/cirrus/github/AlexWayfer/flame-r18n?style=flat-square)](https://cirrus-ci.com/github/AlexWayfer/flame-r18n)
[![Codecov branch](https://img.shields.io/codecov/c/github/AlexWayfer/flame-r18n/master.svg?style=flat-square)](https://codecov.io/gh/AlexWayfer/flame-r18n)
[![Code Climate](https://img.shields.io/codeclimate/maintainability/AlexWayfer/flame-r18n.svg?style=flat-square)](https://codeclimate.com/github/AlexWayfer/flame-r18n)
![Depfu](https://img.shields.io/depfu/AlexWayfer/flame-r18n?style=flat-square)
[![Inline docs](https://inch-ci.org/github/AlexWayfer/flame-r18n.svg?branch=master)](https://inch-ci.org/github/AlexWayfer/flame-r18n)
[![license](https://img.shields.io/github/license/AlexWayfer/flame-r18n.svg?style=flat-square)](https://github.com/AlexWayfer/flame-r18n/blob/master/LICENSE.txt)
[![Gem](https://img.shields.io/gem/v/flame-r18n.svg?style=flat-square)](https://rubygems.org/gems/flame-r18n)

## Usage

```ruby
# Gemfile
gem 'flame-r18n'

# config.ru
require 'flame-r18n' # or `Bundler.require`

# For application configuration
# config/processors/r18n.rb
::R18n.default_places = File.join config[:root_dir], 'locales'
::R18n::I18n.default = 'en'

# _controller.rb
include Flame::R18n::Initialization # for loading thread-based locale

# site/_controller.rb
prepend Flame::R18n::LocaleInPath # for mounting controllers at `/:locale`
```

## Development

After checking out the repo, run `bundle install` to install dependencies.

Then, run `toys rspec` to run the tests.

To install this gem onto your local machine, run `toys gem install`.

To release a new version, run `toys gem release %version%`.
See how it works [here](https://github.com/AlexWayfer/gem_toys#release).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/AlexWayfer/flame-r18n).

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
