# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /login
  def new
    super
  end

  # POST /login
  def create
    super
  end

  # DELETE /logout
  def destroy
    super
  end

  protected

  def after_sign_in_path_for(resource)
    flash[:success] = flash[:notice]
    flash.delete(:notice)
    resource
  end

  def after_sign_out_path_for(resource)
    flash[:success] = flash[:notice]
    flash.delete(:notice)
    root_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
