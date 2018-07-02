class Users::SessionsController < Devise::SessionsController
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if request.xhr?
      resource = User.find_for_authentication(email: params[:user][:email])
      return invalid_login_attempt unless resource
      if resource.valid_password?(params[:user][:password])
        sign_in :user, resource
        redirect_to after_sign_in_path_for(resource)
      end
      invalid_login_attempt
    else
     super
    end
  end

  def invalid_login_attempt
    respond_to do |format|
      format.js
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
