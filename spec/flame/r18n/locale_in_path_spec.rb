# frozen_string_literal: true

describe Flame::R18n::LocaleInPath do
	require 'rack/test'
	include Rack::Test::Methods

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
				# 'index of site'
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
			R18n.default_places = File.join config[:root_dir], 'locales'

			mount site_controller, '/:?locale' do
				mount example_controller, '/'
			end
		end
	end

	let(:app) { application }

	before do
		get path
	end

	describe '#execute' do
		describe 'redirect to path with locale when no locale in requested path' do
			let(:path) { '/foo' }

			it { expect(last_response.redirect?).to be true }
			it { expect(last_response.location).to eq '/en/foo' }
		end

		describe 'no redirect when available locale in requested path' do
			let(:path) { '/en/foo' }

			it { expect(last_response.redirect?).to be false }
			it { expect(last_response.ok?).to be true }
			it { expect(last_response.body).to eq 'foo body' }
		end

		describe 'root path with arguments' do
			let(:path) { '/?foo' }

			it { expect(last_response.redirect?).to be true }
			it { expect(last_response.location).to eq '/en?foo' }
		end
	end

	describe '#default_body' do
		describe 'redirect to path with locale when page without available locale not found' do
			let(:path) { '/bar' }

			it { expect(last_response.redirect?).to be true }
			it { expect(last_response.location).to eq '/en/bar' }
		end

		describe 'no redirect when available locale in nonexistent requested path' do
			let(:path) { '/en/bar' }

			it { expect(last_response.redirect?).to be false }
			it { expect(last_response.not_found?).to be true }
		end
	end

	describe '#path_to' do
		subject { last_response.body }

		context 'when no Hash in arguments' do
			let(:path) { '/it/test_path_to_without_arguments' }

			it { is_expected.to eq '/it/foo' }
		end

		context 'when Hash without `locale` in arguments' do
			let(:path) { '/it/test_path_to_with_arguments' }

			it { is_expected.to eq '/it/foo/2' }
		end

		context 'when Hash with `locale` in arguments' do
			let(:path) { '/it/test_path_to_with_locale_argument' }

			it { is_expected.to eq '/de/foo' }
		end
	end

	describe '#fullpath_without_locale' do
		context 'when locale is available in requested path' do
			describe 'path without locale' do
				let(:path) { '/de/test_fullpath_without_locale' }

				it { expect(last_response.ok?).to be true }
				it { expect(last_response.body).to eq '/test_fullpath_without_locale' }
			end

			context 'with query string in requested path' do
				let(:path) { '/de/test_fullpath_without_locale?foo=bar' }

				it { expect(last_response.ok?).to be true }

				it do
					expect(last_response.body).to eq(
						'/test_fullpath_without_locale?foo=bar'
					)
				end
			end
		end

		context 'when no available locale in requested path' do
			let(:path) { '/nb/test_fullpath_without_locale' }

			it { expect(last_response.ok?).to be true }

			it do
				expect(last_response.body).to eq '/nb/test_fullpath_without_locale'
			end
		end
	end

	describe '#fullpath_with_specific_locale' do
		let(:path) { '/it/test_fullpath_with_specific_locale' }

		it { expect(last_response.ok?).to be true }

		it do
			expect(last_response.body).to eq(
				'/de/test_fullpath_with_specific_locale'
			)
		end
	end
end
