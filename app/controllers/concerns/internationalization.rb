# frozen_string_literal: true

module Internationalization
  extend ActiveSupport::Concern

  included do
    # around_action :switch_locale
    before_action :switch_locale

    private

    def switch_locale(&)
      locale = locale_from_url || locale_from_headers || I18n.default_locale
      response.set_header 'Content-Language', locale
      # I18n.with_locale(locale, &)
      I18n.locale = locale
    end

    # Adapted from https://github.com/rack/rack-contrib/blob/master/lib/rack/contrib/locale.rb
    def locale_from_url
      locale = params[:locale]

      locale if I18n.available_locales.map(&:to_s).include?(locale)
    end

    def locale_from_headers
      http_accept_language.compatible_language_from(I18n.available_locales)
    end

    def default_url_options
      { locale: I18n.locale }
    end
  end
end
