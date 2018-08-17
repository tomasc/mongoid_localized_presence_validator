require 'test_helper'

class MongoidLocalizedPresenceValidatorDoc
  include Mongoid::Document
  field :text, type: String
  field :localized_text, type: String, localize: true
  field :number, type: Integer
  field :localized_number, type: Integer, localize: true
  field :truth, type: Boolean
  field :localized_truth, type: Boolean, localize: true

  validates :text, presence: true, on: :string_default
  validates :text, presence: :default_locale, on: :string_default_locale_only_on_non_localized
  validates :localized_text, presence: true, on: :string_default_localized
  validates :localized_text, presence: %i[cs], on: :string_locales_only
  validates :localized_text, presence: :default_locale, on: :string_default_locale_only
  validates :number, presence: true, on: :integer_default
  validates :number, presence: :default_locale, on: :integer_default_locale_only_on_non_localized
  validates :localized_number, presence: true, on: :integer_default_localized
  validates :localized_number, presence: %i[cs], on: :integer_locales_only
  validates :localized_number, presence: :default_locale, on: :integer_default_locale_only
  validates :truth, presence: true, on: :boolean_default
  validates :truth, presence: :default_locale, on: :boolean_default_locale_only_on_non_localized
  validates :localized_truth, presence: true, on: :boolean_default_localized
  validates :localized_truth, presence: %i[cs], on: :boolean_locales_only
  validates :localized_truth, presence: :default_locale, on: :boolean_default_locale_only
end

describe MongoidLocalizedPresenceValidator::Patch do
  let(:klass) { MongoidLocalizedPresenceValidatorDoc }

  describe 'String' do
    describe 'default, not localized' do
      let(:context) { :string_default }

      it { klass.new(text: 'TEST').valid?(context).must_equal true }
      it { klass.new(text: nil).valid?(context).must_equal false }
    end

    describe ':default_locale, not localized' do
      let(:context) { :string_default_locale_only_on_non_localized }

      it { klass.new(text: 'TEST').valid?(context).must_equal true }
      it { klass.new(text: nil).valid?(context).must_equal false }
    end

    describe 'default, localized' do
      let(:context) { :string_default_localized }

      it { klass.new(localized_text: 'TEST').valid?(context).must_equal true }
      it { klass.new(localized_text: nil).valid?(context).must_equal false }
    end

    describe 'specified locale, localized' do
      let(:context) { :string_locales_only }

      before do
        @available_locales = ::I18n.available_locales
        ::I18n.available_locales = %i[en cs]
      end

      after do
        ::I18n.available_locales = @available_locales
      end

      it { klass.new(localized_text_translations: { 'cs' => 'TEST', 'en' => nil }).valid?(context).must_equal true }
      it { klass.new(localized_text_translations: { 'cs' => nil, 'en' => 'TEST' }).valid?(context).must_equal false }
    end

    describe ':default_locale, localized' do
      let(:context) { :string_default_locale_only }

      before do
        @available_locales = ::I18n.available_locales
        ::I18n.available_locales = %i[en cs]
      end

      after do
        ::I18n.available_locales = @available_locales
      end

      it { klass.new(localized_text_translations: { 'en' => 'TEST', 'cs' => nil }).valid?(context).must_equal true }
      it { klass.new(localized_text_translations: { 'en' => nil, 'cs' => 'TEST' }).valid?(context).must_equal false }
    end
  end

  describe 'Integer' do
    describe 'default, not localized' do
      let(:context) { :integer_default }

      it { klass.new(number: 1337).valid?(context).must_equal true }
      it { klass.new(number: nil).valid?(context).must_equal false }
    end

    describe ':default_locale, not localized' do
      let(:context) { :integer_default_locale_only_on_non_localized }

      it { klass.new(number: 1337).valid?(context).must_equal true }
      it { klass.new(number: nil).valid?(context).must_equal false }
    end

    describe 'default, localized' do
      let(:context) { :integer_default_localized }

      it { klass.new(localized_number: 1337).valid?(context).must_equal true }
      it { klass.new(localized_number: nil).valid?(context).must_equal false }
    end

    describe 'specified locale, localized' do
      let(:context) { :integer_locales_only }

      before do
        @available_locales = ::I18n.available_locales
        ::I18n.available_locales = %i[en cs]
      end

      after do
        ::I18n.available_locales = @available_locales
      end

      it { klass.new(localized_number_translations: { 'cs' => 1337, 'en' => nil }).valid?(context).must_equal true }
      it { klass.new(localized_number_translations: { 'cs' => nil, 'en' => 1337 }).valid?(context).must_equal false }
    end

    describe ':default_locale, localized' do
      let(:context) { :integer_default_locale_only }

      before do
        @available_locales = ::I18n.available_locales
        ::I18n.available_locales = %i[en cs]
      end

      after do
        ::I18n.available_locales = @available_locales
      end

      it { klass.new(localized_number_translations: { 'en' => 1337, 'cs' => nil }).valid?(context).must_equal true }
      it { klass.new(localized_number_translations: { 'en' => nil, 'cs' => 1337 }).valid?(context).must_equal false }
    end
  end

  describe 'Boolean' do
    describe 'default, not localized' do
      let(:context) { :boolean_default }

      it { klass.new(truth: false).valid?(context).must_equal true }
      it { klass.new(truth: nil).valid?(context).must_equal false }
    end

    describe ':default_locale, not localized' do
      let(:context) { :boolean_default_locale_only_on_non_localized }

      it { klass.new(truth: false).valid?(context).must_equal true }
      it { klass.new(truth: nil).valid?(context).must_equal false }
    end

    describe 'default, localized' do
      let(:context) { :boolean_default_localized }

      it { klass.new(localized_truth: false).valid?(context).must_equal true }
      it { klass.new(localized_truth: nil).valid?(context).must_equal false }
    end

    describe 'specified locale, localized' do
      let(:context) { :boolean_locales_only }

      before do
        @available_locales = ::I18n.available_locales
        ::I18n.available_locales = %i[en cs]
      end

      after do
        ::I18n.available_locales = @available_locales
      end

      it { klass.new(localized_truth_translations: { 'cs' => false, 'en' => nil }).valid?(context).must_equal true }
      it { klass.new(localized_truth_translations: { 'cs' => nil, 'en' => false }).valid?(context).must_equal false }
    end

    describe ':default_locale, localized' do
      let(:context) { :boolean_default_locale_only }

      before do
        @available_locales = ::I18n.available_locales
        ::I18n.available_locales = %i[en cs]
      end

      after do
        ::I18n.available_locales = @available_locales
      end

      it { klass.new(localized_truth_translations: { 'en' => false, 'cs' => nil }).valid?(context).must_equal true }
      it { klass.new(localized_truth_translations: { 'en' => nil, 'cs' => false }).valid?(context).must_equal false }
    end
  end
end
