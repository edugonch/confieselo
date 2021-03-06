class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?

  def create
        if verify_recaptcha
          super
          FeedWorker.perform_async(@user.id.to_s)
        else
          build_resource(sign_up_params)
          clean_up_passwords(resource)
          flash.now[:alert] = "Hubo un error con el código de verificación. Por favor, vuelva a introducir el código."      
          flash.delete :recaptcha_error
          render :new
        end
   end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:username, :email, :password, :password_confirmation, :current_password)}
  end

end
