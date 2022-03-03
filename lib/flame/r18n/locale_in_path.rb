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
				unless request_path_with_available_locale?
					return halt redirect_to_path_with_preferred_locale
				end

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

			def redirect_to_path_with_preferred_locale
				redirect path_with_preferred_locale.sub(%r{(/)+(?=\?|$)}, ''), 302
			end

			def path_with_preferred_locale
				Flame::Path.merge(nil, r18n.locale.code, request.fullpath)
			end

			## Get the current path without the preferred locale in it
			## @return [Flame::Path] the current path without locale in it
			def fullpath_without_locale
				return request.fullpath.to_s unless request_path_with_available_locale?

				Flame::Path.merge(
					request.fullpath.to_s.split('/')[2..].unshift('/')
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
		end
	end
end
