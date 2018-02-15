# frozen_string_literal: true

module Flame
	module R18n
		## Module for including to controllers, mounted with `:locale` param in path
		module LocaleInPath
			protected

			## Patch controller execution
			## Halt with redirect to the same URL, but with the preferred locale,
			## if necessary
			## @param action [Symbol] action which will be executed
			def execute(action)
				halt_redirect_with_preferred_locale_in_path_if_necessary
				super
			end

			## Halt with redirect to the same URL, but with the preferred locale,
			## if necessary, if current response is Not Found
			def not_found
				halt_redirect_with_preferred_locale_in_path_if_necessary
				super
			end

			private

			## Complete returning path with locale, if necessary
			def path_to(*args)
				args << {} unless args.last.is_a? Hash
				args.last[:locale] = r18n.locale.code unless args.last.include?(:locale)
				super
			end

			def request_path_with_available_locale?
				available_locale_codes.include?(request.path.parts.first.to_s)
			end

			def redirect_with_preferred_locale_in_path
				path_with_locale = Flame::Path.merge(
					nil, r18n.locale.code, request.fullpath
				)
				path_with_locale.sub!(%r{(/)+(?=\?|$)}, '')
				redirect path_with_locale, 302
			end

			## Get the current path without the preferred locale in it
			## @return [Flame::Path] the current path without locale in it
			def path_without_locale
				return request.path.to_s unless request_path_with_available_locale?
				Flame::Path.merge(
					request.path.parts[1..-1].unshift('/')
				)
			end

			## Get the current path with the specific locale in it
			## @param locale [R18n::Locale] the locale that will be in the path
			## @return [Flame::Path] the current path with the specific locale in it
			def fullpath_with_specific_locale(locale)
				fullpath_parts = request.fullpath.to_s.split('/')
				fullpath_parts[1] = locale.code
				Flame::Path.merge fullpath_parts
			end

			def halt_redirect_with_preferred_locale_in_path_if_necessary
				return if request_path_with_available_locale?
				halt redirect_with_preferred_locale_in_path
			end
		end
	end
end
