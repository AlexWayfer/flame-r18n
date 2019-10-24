# frozen_string_literal: true

module Flame
	module R18n
		## Module for R18n in thread initialization with helper methods
		module Initialization
			include ::R18n::Helpers

			## Patch controller initialization
			## Load R18n and set the current locale to the session
			def initialize(*)
				super
				load_r18n
				session[:locale] = r18n.locale.code
			end

			## Force change thread locale
			## @param locale [R18n::Locale] the locale that will be set
			def thread_locale=(locale)
				::R18n.thread_set init_r18n locale
			end

			private

			def locales_from_env
				::R18n::I18n.parse_http(request.env['HTTP_ACCEPT_LANGUAGE'])
			end

			def preferred_locale
				locale_param || session[:locale]
			end

			def locale_param
				params[:locale] if available_locale_codes.include?(params[:locale])
			end

			def available_locale_codes
				::R18n.available_locales.map(&:code)
			end

			def load_r18n
				::R18n.clear_cache! if config[:environment] == 'development'

				self.thread_locale = preferred_locale
			end

			def init_r18n(locale)
				::R18n::I18n.new(
					Array(locale) | locales_from_env,
					::R18n.default_places,
					off_filters: :untranslated,
					on_filters: :untranslated_html
				)
			end
		end
	end
end
