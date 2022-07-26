# frozen_string_literal: true

module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :notfound
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def notfound(exception)
      logger.warn exception
      render file: 'public/404.html', status: :not_found, layout: false
    end

    def user_not_authorized
      flash[:danger] = t('global.flash.not_authorized')
      redirect_to(request.referer || root_path, status: :see_other)
    end
  end
end
