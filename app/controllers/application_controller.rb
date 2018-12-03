class ApplicationController < ActionController::Base
	helper_method :current_user

	def login_required
		redirect_to root_url if current_user.blank?
  end

  def current_user
    if session[:employee_id]
      @current_user ||= Employee.find(session[:employee_id])
    else
      @current_user = nil
    end
  end
end
