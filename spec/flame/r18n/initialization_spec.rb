# frozen_string_literal: true

describe Flame::R18n::Initialization do
	module R18n
		module Locales
			class RuRU < Ru
				set sublocales: %w[ru]
			end

			Ru.set sublocales: %w[ru-RU]

			class DeDE < De
				set sublocales: %w[de]
			end

			De.set sublocales: %w[de-DE]
		end
	end

	let(:controller_class) do
		Class.new(Flame::Controller) do
			include Flame::R18n::Initialization
		end
	end

	let(:locales_dir) { 'locales' }

	let(:application) do
		locales_dir = self.locales_dir
		controller_class = self.controller_class

		Class.new(Flame::Application) do
			::R18n.default_places = File.join config[:root_dir], locales_dir

			mount controller_class
		end
	end

	let(:env) do
		{
			Rack::RACK_URL_SCHEME => 'http',
			Rack::SERVER_NAME => 'localhost',
			Rack::SERVER_PORT => 3000,
			Rack::RACK_INPUT => StringIO.new,
			Rack::QUERY_STRING => query_string,
			Rack::RACK_SESSION => rack_session,
			'HTTP_ACCEPT_LANGUAGE' => accept_language
		}
	end

	let(:query_string) {}
	let(:rack_session) { {} }
	let(:accept_language) {}

	def initialize_controller
		controller_class.new(Flame::Dispatcher.new(application, env))
	end

	let(:controller) { initialize_controller }

	before do
		## For application preloading with `Flame::Dispatcher`
		application
	end

	describe 'controller includes ::R18n::Helpers' do
		subject { controller }

		it { is_expected.to respond_to :r18n }
		it { is_expected.to respond_to :t }
		it { is_expected.to respond_to :l }
	end

	describe '#initialize' do
		describe 'loading R18n' do
			describe 'cache clearing' do
				let(:initialize_controller_times) { 5 }

				before do
					application.config[:environment] = environment
					allow(R18n).to receive(:clear_cache!).and_call_original
					initialize_controller_times.times { initialize_controller }
				end

				describe 'in development environment' do
					let(:environment) { 'development' }

					it do
						expect(R18n).to have_received(:clear_cache!)
							.exactly(initialize_controller_times).times
					end
				end

				describe 'in production environment' do
					let(:environment) { 'production' }

					it { expect(R18n).not_to have_received(:clear_cache!) }
				end
			end

			subject { controller.r18n.locale.code }

			context 'locale in param' do
				let(:query_string) { 'locale=de' }

				it { is_expected.to eq 'de' }
			end

			context 'locale in session' do
				let(:rack_session) { { locale: 'it' } }

				it { is_expected.to eq 'it' }
			end

			context 'locale in HTTP header' do
				let(:accept_language) { 'de,en;q=0.9,ru;q=0.8' }

				it do
					expect(controller.r18n.locales.map(&:code))
						.to eq %w[de de-DE en en-US en-GB en-AU ru ru-RU]
				end

				describe 'locales with regions' do
					let(:locales_dir) { 'locales_with_regions' }
					let(:accept_language) { 'de,en;q=0.9,ru;q=0.8,foo;q=0.7' }

					it { is_expected.to eq 'de-DE' }
				end
			end

			describe 'R18n filters' do
				subject do
					controller.r18n.filter_list.all(R18n::Untranslated)
						.any? { |filter| filter.name == filter_name }
				end

				describe ':untranslated is off' do
					let(:filter_name) { :untranslated }

					it { is_expected.to be false }
				end

				describe ':untranslated_html is on' do
					let(:filter_name) { :untranslated_html }

					it { is_expected.to be true }
				end
			end
		end

		describe 'setting session locale' do
			subject { controller.session[:locale] }

			it { is_expected.to eq R18n.get.locale.code }
		end
	end

	describe '#thread_locale=' do
		before do
			controller.thread_locale = 'ru'
		end

		subject { controller.r18n.locale.code }

		it { is_expected.to eq 'ru' }
	end
end
