class ApplicationController < ActionController::Base
  respond_to :html, :json
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  ## Exception Handling
  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, :with => :access_denied

  def initialize
    @languages = [
       {"id" => 'en', "name" => t("languages.english")},
       {"id" => 'es', "name" => t("languages.spanish")}
    ]
    super
  end

  def access_denied(exception)
    flash.delete(:notice)
    flash[:error] = I18n.t "errors.access_denied"
    sign_out(current_user)
    redirect_to root_url
  end

  def admin_required
    raise AccessDenied unless current_user.is_admin?
  end

  def employee_required
    raise AccessDenied unless current_user.is_employee?
  end

  protected
  def after_sign_in_path_for(resource)
    set_locale
    if resource.is_employee? && resource.employee.is_active?
      if resource.sign_in_count == 1
        confirmation_path
      else
        employee = resource.employee
        session[:employee_id] = employee.id
        session[:project_id] = employee.project.id
        flash[:notice] = I18n.t "messages.wellcome"
        new_assignment_path
      end
    elsif resource.is_admin?
      "/admin"
    else
      raise AccessDenied
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :password, :current_password])
  end

  private

  # Cambia el idioma
  def set_locale
    logger.debug "* Accept-Language: #{params[:locale]}"
    locale = params[:locale]
    if locale != "es"
      I18n.locale = :en
    else
      I18n.locale = :es
    end
    @locale = I18n.locale
    logger.debug "* Locale set to '#{I18n.locale}'"
  end
end
