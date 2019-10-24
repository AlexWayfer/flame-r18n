# Flame R18n

[![Travis branch](https://img.shields.io/travis/AlexWayfer/flame-r18n/master.svg?style=flat-square)](https://travis-ci.org/AlexWayfer/flame-r18n)
[![Codecov branch](https://img.shields.io/codecov/c/github/AlexWayfer/flame-r18n/master.svg?style=flat-square)](https://codecov.io/gh/AlexWayfer/flame-r18n)
[![Code Climate](https://img.shields.io/codeclimate/maintainability/AlexWayfer/flame-r18n.svg?style=flat-square)](https://codeclimate.com/github/AlexWayfer/flame-r18n)
[![Gemnasium](https://img.shields.io/gemnasium/AlexWayfer/flame-r18n.svg?style=flat-square)](https://gemnasium.com/github.com/AlexWayfer/flame-r18n)
[![Inline docs](https://inch-ci.org/github/AlexWayfer/flame-r18n.svg?branch=master)](https://inch-ci.org/github/AlexWayfer/flame-r18n)
[![Gem](https://img.shields.io/gem/v/flame-r18n.svg?style=flat-square)](https://rubygems.org/gems/flame-r18n)
[![license](https://img.shields.io/github/license/AlexWayfer/flame-r18n.svg?style=flat-square)](https://github.com/AlexWayfer/flame-r18n/blob/master/LICENSE)

[R18n](https://github.com/ai/r18n) helper for
[Flame](https://github.com/AlexWayfer/flame)

## Using

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
