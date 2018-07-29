# frozen_string_literal: true

# Module for user functions
module Users
  # Devise controller for handling registration
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]
    # prepend_before_action :check_captcha, only: [:create]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    def create
      if verify_recaptcha
        super
      else
        flash.now[:alert] = 'Recaptcha verification failed'
        flash.delete :recaptcha_error
        build_resource(sign_up_params)
        resource.validate
        puts "sign_up_params: #{sign_up_params}"
        puts "resource: #{resource.inspect}"
        puts "resource errors: #{resource.errors.messages}"
        clean_up_passwords(resource)
        set_minimum_password_length
        render :new
      end
    end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    # def update
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, \
                                        keys: %i[name date_of_birth username terms_of_service])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, \
                                        keys: %i[name date_of_birth username])
    end

    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        resource.validate # Look for any other validation errors
        set_minimum_password_length
        puts "resource: #{resource.inspect}"
        puts "Path: #{new_user_registration_path}"
        respond_with resource, location: new_user_registration_path(resource)
      end
    end

    # The path used after sign up.
    def after_sign_up_path_for(resource)
      super(resource)
    end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end
end
