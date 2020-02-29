# frozen_string_literal: true

require_relative '../../spec_helper'

describe Flame::R18n::LocaleInPath do
	let(:common_controller) do
		Class.new(Flame::Controller) do
			include Flame::R18n::Initialization
		end
	end

	let(:site_controller) do
		Class.new(common_controller) do
			prepend Flame::R18n::LocaleInPath
		end
	end

	let(:example_controller) do
		Class.new(site_controller) do
			def index
				'index of site'
			end

			def foo(_arg = nil)
				'foo body'
			end

			## test path_to

			def test_path_to_without_arguments
				path_to :foo
			end

			def test_path_to_with_arguments
				path_to :foo, _arg: 2
			end

			def test_path_to_with_locale_argument
				path_to :foo, locale: 'de'
			end

			def test_fullpath_without_locale
				fullpath_without_locale
			end

			protected

			def execute(action)
				if request.path.to_s.start_with?('/nb/test_fullpath_without_locale')
					return body fullpath_without_locale
				end

				super
			end

			## test fullpath_with_specific_locale

			public

			def test_fullpath_with_specific_locale
				de_locale = R18n::I18n.new('de').locale
				fullpath_with_specific_locale(de_locale)
			end
		end
	end

	let(:application) do
		site_controller = self.site_controller
		example_controller = self.example_controller

		Class.new(Flame::Application) do
			::R18n.default_places = File.join config[:root_dir], 'locales'

			mount site_controller, '/:?locale' do
				mount example_controller, '/'
			end
		end
	end

	require 'rack/test'
	include Rack::Test::Methods

	let(:app) { application }

	describe '#execute' do
		it 'redirects to path with locale when no locale in requested path' do
			get '/foo'
			last_response.redirect?.must_equal true
			last_response.location.must_equal '/en/foo'
		end

		it "doesn't redirect when available locale in requested path" do
			get '/en/foo'
			last_response.redirect?.must_equal false
			last_response.ok?.must_equal true
			last_response.body.must_equal 'foo body'
		end

		describe 'root path with arguments' do
			it 'redirects to root path with locale without extra slashes' do
				get '/?foo'
				last_response.redirect?.must_equal true
				last_response.location.must_equal '/en?foo'
			end
		end
	end

	describe '#default_body' do
		it 'redirects to path with locale when page without available locale' \
		   ' not found' do
			get '/bar'
			last_response.redirect?.must_equal true
			last_response.location.must_equal '/en/bar'
		end

		it "doesn't redirect when available locale in nonexistent requested path" do
			get '/en/bar'
			last_response.redirect?.must_equal false
			last_response.not_found?.must_equal true
		end
	end

	describe '#path_to' do
		describe 'when no Hash in arguments' do
			it 'builds path with current locale' do
				get '/it/test_path_to_without_arguments'
				last_response.body.must_equal '/it/foo'
			end
		end

		describe 'when Hash without `locale` in arguments' do
			it 'builds path with current locale' do
				get '/it/test_path_to_with_arguments'
				last_response.body.must_equal '/it/foo/2'
			end
		end

		describe 'when Hash with `locale` in arguments' do
			it "doesn't build path with current locale" do
				get '/it/test_path_to_with_locale_argument'
				last_response.body.must_equal '/de/foo'
			end
		end
	end

	describe '#fullpath_without_locale' do
		describe 'available locale in requested path' do
			it 'returns path without locale' do
				get '/de/test_fullpath_without_locale'
				last_response.ok?.must_equal true
				last_response.body.must_equal '/test_fullpath_without_locale'
			end

			describe 'with query string in requested path' do
				it 'returns full path without locale' do
					get '/de/test_fullpath_without_locale?foo=bar'
					last_response.ok?.must_equal true
					last_response.body.must_equal '/test_fullpath_without_locale?foo=bar'
				end
			end
		end

		describe 'no available locale in requested path' do
			it 'returns current path' do
				get '/nb/test_fullpath_without_locale'
				last_response.ok?.must_equal true
				last_response.body.must_equal '/nb/test_fullpath_without_locale'
			end
		end
	end

	describe '#fullpath_with_specific_locale' do
		it 'returns path with specific locale' do
			get '/it/test_fullpath_with_specific_locale'
			last_response.ok?.must_equal true
			last_response.body.must_equal '/de/test_fullpath_with_specific_locale'
		end
	end
end
