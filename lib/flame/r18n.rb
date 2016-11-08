require 'r18n-core'

module Flame
	# Module for Flame::R18n extension with helper methods and base class
	module R18n
		include ::R18n::Helpers

		def self.config(app)
			app.config[:default_locale] = proc { ::R18n::I18n.default }
			app.config[:locales] = proc { ::R18n.default_places }
			app.config[:locales_dir] = proc do
				File.join(app.config[:root_dir], 'locales')
			end

			::R18n.default_places { app.config[:locales_dir] }
		end

		def execute(method)
			load_r18n
			session[:locale] = (
				preferred_locale || ::R18n.get.locale.code
			).gsub(/^\W+|\W+$/, '')
			super
		end

		private

		def init_r18n
			::R18n::I18n.new(
				locales_from_env,
				::R18n.default_places,
				off_filters: :untranslated,
				on_filters: :untranslated_html
			)
		end

		def locales_from_env
			locales = ::R18n::I18n.parse_http(request.env['HTTP_ACCEPT_LANGUAGE'])
			locales = [preferred_locale] | locales if preferred_locale
			locales
		end

		def preferred_locale
			return super if defined? super
			params[:locale] || session[:locale]
		end

		def load_r18n
			::R18n.clear_cache! if config[:environment] == 'development'

			::R18n.thread_set do
				default_locale = config[:default_locale]
				::R18n::I18n.default = default_locale if default_locale

				init_r18n
			end
		end
	end
end
