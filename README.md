# Flame R18n

[R18n](https://github.com/ai/r18n) helper for
[Flame](https://github.com/AlexWayfer/flame)

## Using

```ruby
# Gemfile
gem 'flame-r18n'

# config.ru
require 'flame-r18n' # or `Bundler.require`

# app.rb
include Flame::R18n::Configuration # for application configuration

# _controller.rb
include Flame::R18n::Initialization # for loading thread-based locale

# site/_controller.rb
include Flame::R18n::LocaleInPath # for mounting controllers at `/:locale`
```
