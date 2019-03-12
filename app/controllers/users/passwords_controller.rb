# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render :new
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        resource.after_database_authentication
        resource.confirm if resource.confirmed_at.nil?
        sign_in(resource_name, resource)
        flash[:success] = "Password has been reset."
        redirect_to resource
      else
        set_flash_message!(:danger, :updated_not_active)
        redirect_to root_url
      end
    else
      set_minimum_password_length
      render :edit
    end
  end

  # protected
  #
  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end
  #
  # # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
