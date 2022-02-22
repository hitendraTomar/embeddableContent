class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

    def after_sign_out_path_for(_resource)
      new_user_session_path
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: %i[name email password])
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password user_type])
    end
end
