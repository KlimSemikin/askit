# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: %i[destroy]
  before_action :set_user, only: %i[create]

  def new; end

  def create
    if @user&.authenticate(params[:password])
      do_sign_in @user
      flash[:success] = t('.success', name: current_user.name_or_email)
      redirect_to root_path
    else
      flash[:warning] = t('.warning')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    flash[:success] = t('.success')
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find_by(email: params[:email])
  end

  def do_sign_in(user)
    sign_in user
    case params[:remember_me]
    when '1'
      remember(user)
    when '0'
      forget(user)
    end
  end
end
