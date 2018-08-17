require 'mongoid'

module MongoidLocalizedPresenceValidator
  module Patch
    def validate_each(document, attribute, value)
      field = document.fields[document.database_field_name(attribute)]
      return super(document, attribute, value) unless field.try(:localized?)

      in_option = options.fetch(:in, nil)
      with_option = options.fetch(:with, nil)

      with_option = ::I18n.default_locale if with_option == :default_locale

      locales = Array(in_option || with_option).select { |l| ::I18n.available_locales.include?(l.to_sym) }

      if locales.present?
        locales.each do |_locale|
          _value = value.fetch(_locale.to_s, nil)
          next unless not_present?(_value)
          document.errors.add(
            attribute,
            :blank_in_locale,
            options.merge(location: _locale)
          )
        end
      else
        super(document, attribute, value)
      end
    end
  end
end

Mongoid::Validatable::PresenceValidator.send(:prepend, MongoidLocalizedPresenceValidator::Patch)
