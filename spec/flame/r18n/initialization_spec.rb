# frozen_string_literal: true

describe Flame::R18n::Initialization do
	module Initialization
		class TestController < Flame::Controller
			include Flame::R18n::Initialization
		end
	end

	let(:application) do
		Class.new(Flame::Application) do
			include Flame::R18n::Configuration

			mount Initialization::TestController
		end
	end

	let(:env) do
		{
			Rack::RACK_URL_SCHEME => 'http',
			Rack::SERVER_NAME => 'localhost',
			Rack::SERVER_PORT => 3000,
			Rack::RACK_INPUT => StringIO.new
		}
	end

	let(:dispatcher) { Flame::Dispatcher.new(application, env) }

	def controller_init
		Initialization::TestController.new(dispatcher)
	end

	let(:controller) { controller_init }

	it 'includes ::R18n::Helpers' do
		controller.must_respond_to :r18n
		controller.must_respond_to :t
		controller.must_respond_to :l
	end

	describe '#initialize' do
		describe 'loading R18n' do
			describe 'cache clearing' do
				def count_cache_cleared_times
					cache_cleared_times = 0
					R18n.stub :clear_cache!, -> { cache_cleared_times += 1 } do
						5.times { controller_init }
					end
					cache_cleared_times
				end

				describe 'in development environment' do
					before { application.config[:environment] = 'development' }

					it 'works' do
						count_cache_cleared_times.must_equal 5
					end
				end

				describe 'in production environment' do
					before { application.config[:environment] = 'production' }

					it "doesn't work" do
						count_cache_cleared_times.must_equal 0
					end
				end
			end

			it 'sets default locale from application config' do
				original_default = ::R18n::I18n.default
				application.config[:default_locale] = 'it'
				controller_init
				::R18n::I18n.default.must_equal 'it'
				::R18n::I18n.default = original_default
			end

			it 'sets locale from param' do
				env[Rack::QUERY_STRING] = 'locale=de'
				controller.r18n.locale.code.must_equal 'de'
			end

			it 'sets locale from session' do
				env[Rack::RACK_SESSION] = { locale: 'it' }
				controller.r18n.locale.code.must_equal 'it'
			end

			it 'sets locales from HTTP header' do
				env['HTTP_ACCEPT_LANGUAGE'] = 'de,en;q=0.9,ru;q=0.8'
				controller.r18n.locales.map(&:code).must_equal %w[de en ru]
			end

			it 'turns R18n :untranslated filter off' do
				controller.r18n.filter_list.all(R18n::Untranslated)
					.any? { |filter| filter.name == :untranslated }
					.must_equal false
			end

			it 'turns R18n :untranslated_html filter on' do
				controller.r18n.filter_list.all(R18n::Untranslated)
					.any? { |filter| filter.name == :untranslated_html }
					.must_equal true
			end
		end

		it 'sets session locale' do
			controller.session[:locale].must_equal R18n.get.locale.code
		end
	end

	describe '#thread_locale=' do
		it 'sets R18n thread locale' do
			controller.thread_locale = 'ru'
			controller.r18n.locale.code.must_equal 'ru'
		end
	end
end