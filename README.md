# Flame R18n

[R18n](https://github.com/ai/r18n) helper for [Flame](https://github.com/AlexWayfer/flame)

## Using

```ruby
# Gemfile
gem 'flame-r18n', '~> 1'

# config.ru
require 'flame-r18n' # or `Bundler.require`

# _base_controller.rb
prepend Flame::R18n # for loading before controller's execute
```
