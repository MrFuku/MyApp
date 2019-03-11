# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :admin_user,     only: :destroy

  # GET /sign_up
  def new
    super
  end

  # POST /sign_up
  def create
    super
  end

  # GET /edit
  def edit
    super
  end

  # PUT /
  def update
    super
  end

  # DELETE /users/:id
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) if !current_user.admin?
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  def after_sign_up_path_for(resource)

  end

  # def after_inactive_sign_up_path_for(resource)
  #
  #   # メール認証による処理実装後修正する
  #   # resource.confirm
  #   # flash[:notice] = nil
  #   # flash[:success] = "Welcome to the Sample App!"
  #   # sign_in(resource_name, resource)
  #   # resource
  # end

  def after_update_path_for(resource)
    flash[:success] = flash[:notice]
    flash[:notice] = nil
    resource
  end
end
