# frozen_string_literal: true

module Flame
	module R18n
		## Module for adding Flame::R18n properties into application configuration
		module Configuration
			def self.included(app)
				app.config[:locales_dir] = proc do
					File.join(app.config[:root_dir], 'locales')
				end

				::R18n.default_places { app.config[:locales_dir] }

				app.config[:default_locale] = proc { ::R18n::I18n.default }
				app.config[:locales] = proc { ::R18n.default_places }
			end
		end
	end
end
