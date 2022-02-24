class ApplicationController < ActionController::Base

  before_action :set_publisher
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

    def set_publisher
      @current_publisher = Publisher.find_by('lower(name) = ?', request.subdomain.downcase.gsub('-', ' '))
    end

    def after_sign_out_path_for(_resource)
      new_user_session_path
    end

    def after_sign_up_path_for(resource)
      root_path
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: %i[name email password])
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password type])
    end
end
