class SessionsController < ApplicationController
  layout 'assignment'
  before_action :authenticate_user!
  before_action :employee_required

  def confirmation
  end

  def edit
    #current_user.update(password: current_user.employee.birthdate.strftime("%Y%m%d"))
    employee = Employee.find(params[:id])
    session[:employee_id] = employee.id
    flash[:notice] = I18n.t "messages.wellcome"
    redirect_to new_assignment_path
  end
end
