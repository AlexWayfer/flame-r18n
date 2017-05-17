# frozen_string_literal: true

require 'r18n-core'

module Flame
	module R18n
		## Module for R18n in thread initialization with helper methods
		module Initialization
			include ::R18n::Helpers

			def initialize(*)
				super
				load_r18n
				session[:locale] = r18n.locale.code
			end

			def init_r18n(locale)
				::R18n::I18n.new(
					Array(locale) | locales_from_env,
					::R18n.default_places,
					off_filters: :untranslated,
					on_filters: :untranslated_html
				)
			end

			def thread_locale=(locale)
				::R18n.thread_set init_r18n locale
			end

			private

			def locales_from_env
				::R18n::I18n.parse_http(request.env['HTTP_ACCEPT_LANGUAGE'])
			end

			def preferred_locale
				params[:locale] || session[:locale]
			end

			def load_r18n
				::R18n.clear_cache! if config[:environment] == 'development'

				::R18n.thread_set do
					default_locale = config[:default_locale]
					::R18n::I18n.default = default_locale if default_locale

					init_r18n preferred_locale
				end
			end
		end
	end
end
