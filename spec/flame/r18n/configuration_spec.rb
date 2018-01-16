# frozen_string_literal: true

describe Flame::R18n::Configuration do
	let(:app) do
		Class.new(Flame::Application) do
			include Flame::R18n::Configuration
		end
	end

	describe 'changing R18n config' do
		before { app } # load lazy variable

		it 'sets default places' do
			::R18n.default_places.must_equal app.config[:locales_dir]
		end
	end

	describe 'filling application config' do
		it 'sets default locale' do
			app.config[:default_locale].must_equal ::R18n::I18n.default
		end

		it 'sets locales' do
			app.config[:locales].must_equal ::R18n.default_places
		end

		it 'sets locales directory' do
			app.config[:locales_dir].must_equal(
				File.join(app.config[:root_dir], 'locales')
			)
		end
	end
end
