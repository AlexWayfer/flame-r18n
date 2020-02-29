# Flame R18n

[R18n](https://github.com/ai/r18n) helper for
[Flame](https://github.com/AlexWayfer/flame).

[![Cirrus CI - Base Branch Build Status](https://img.shields.io/cirrus/github/AlexWayfer/flame-r18n?style=flat-square)](https://cirrus-ci.com/github/AlexWayfer/flame-r18n)
[![Codecov branch](https://img.shields.io/codecov/c/github/AlexWayfer/flame-r18n/master.svg?style=flat-square)](https://codecov.io/gh/AlexWayfer/flame-r18n)
[![Code Climate](https://img.shields.io/codeclimate/maintainability/AlexWayfer/flame-r18n.svg?style=flat-square)](https://codeclimate.com/github/AlexWayfer/flame-r18n)
![Depfu](https://img.shields.io/depfu/AlexWayfer/flame-r18n?style=flat-square)
[![Inline docs](https://inch-ci.org/github/AlexWayfer/flame-r18n.svg?branch=master)](https://inch-ci.org/github/AlexWayfer/flame-r18n)
[![license](https://img.shields.io/github/license/AlexWayfer/flame-r18n.svg?style=flat-square)](https://github.com/AlexWayfer/flame-r18n/blob/master/LICENSE)
[![Gem](https://img.shields.io/gem/v/flame-r18n.svg?style=flat-square)](https://rubygems.org/gems/flame-r18n)

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
