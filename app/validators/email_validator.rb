# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    msg = I18n.t('global.errors.invalid_format')
    record.errors.add attribute, (options[:message] || msg) unless email_valid?(value)
  end

  def email_valid?(value)
    URI::MailTo::EMAIL_REGEXP.match? value
  end
end
