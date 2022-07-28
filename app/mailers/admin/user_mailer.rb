module Admin
  class UserMailer < ApplicationMailer
    def bulk_import_done
      @user = params[:user]

      mail to: @user.email, subject: t('.subject')
    end

    def bulk_import_fail
      @error = params[:error]
      @user = params[:user]

      mail to: @user.email, subject: t('.subject')
    end
  end
end
