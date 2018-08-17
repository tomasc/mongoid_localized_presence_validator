require 'test_helper'

class LocalizedPresenceValidatorDoc
  include Mongoid::Document
  field :text, type: String
  validates :text, presence: true

  field :text_2, type: String
  validates :text_2, presence: :default_locale

  field :localized_text, type: String, localize: true
  validates :localized_text, presence: true

  field :localized_text_2, type: String, localize: true
  validates :localized_text_2, presence: :cs

  field :localized_text_3, type: String, localize: true
  validates :localized_text_3, presence: %i[cs en]

  field :localized_text_4, type: String, localize: true
  validates :localized_text_4, presence: :default_locale
end

describe LocalizedPresenceValidator::Patch do
  let(:klass) { LocalizedPresenceValidatorDoc }

  describe 'default, not localized' do
    let(:context) { :default }

    it { klass.new(text: 'TEST').valid?(context).must_equal true }
    it { klass.new(text: nil).valid?(context).must_equal false }
  end

  describe ':default_locale, not localized' do
    let(:context) { :default_locale_only_on_non_localized }

    it { klass.new(text_2: 'TEST').valid?(context).must_equal true }
    it { klass.new(text_2: nil).valid?(context).must_equal false }
  end

  describe 'default, localized' do
    let(:context) { :default_localized }

    it { klass.new(localized_text: 'TEST').valid?(context).must_equal true }
    it { klass.new(localized_text: nil).valid?(context).must_equal false }
  end

  describe 'specified locale, localized' do
    let(:context) { :locales_only }

    before do
      @available_locales = ::I18n.available_locales
      ::I18n.available_locales = %i[en cs]
    end

    after do
      ::I18n.available_locales = @available_locales
    end

    it { klass.new(localized_field_2_translations: { 'cs' => 'TEST', 'en' => nil }).valid?(context).must_equal true }
    it { klass.new(localized_field_2_translations: { 'cs' => nil, 'en' => 'TEST' }).valid?(context).must_equal false }
  end

  describe ':default_locale, localized' do
    let(:context) { :default_locale_only }

    before do
      @available_locales = ::I18n.available_locales
      ::I18n.available_locales = %i[en cs]
    end

    after do
      ::I18n.available_locales = @available_locales
    end

    it { klass.new(localized_field_3_translations: { 'en' => 'TEST', 'cs' => nil }).valid?(context).must_equal true }
    it { klass.new(localized_field_3_translations: { 'en' => nil, 'cs' => 'TEST' }).valid?(context).must_equal false }
  end
end
