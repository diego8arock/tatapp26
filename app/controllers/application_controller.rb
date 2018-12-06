class ApplicationController < ActionController::Base
  respond_to :html, :json
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?## Exception Handling
  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, :with => :access_denied

  def access_denied(exception)
    flash[:notice] = I18n.t "errors.access_denied"
    sign_out_and_redirect(current_user)
  end

  def admin_required
    raise AccessDenied unless current_user.is_admin?
  end

  def employee_required
    raise AccessDenied unless current_user.is_employee?
  end

  protected
  def after_sign_in_path_for(resource)
    if resource.is_employee?
      confirmation_path
    else
      "/admin"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :password, :current_password])
  end
end
