# frozen_string_literal: true

module Flame
	module R18n
		## Module for including to controllers, mounted with `:locale` param in path
		module LocaleInPath
			include Flame::R18n::Initialization

			protected

			def execute(method)
				unless request_path_with_available_locale?
					return redirect_with_preferred_locale_in_path
				end
				super
			end

			private

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
				path_with_locale.sub!(%r{(\/)+$}, '')
				redirect path_with_locale, 302
			end

			def path_without_locale
				return request.path.to_s unless request_path_with_available_locale?
				Flame::Path.merge(
					request.path.parts[1..-1].unshift('/')
				)
			end

			def fullpath_with_specific_locale(locale)
				fullpath_parts = request.fullpath.to_s.split('/')
				fullpath_parts[1] = locale.code
				Flame::Path.merge fullpath_parts
			end
		end
	end
end
