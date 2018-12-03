class SessionsController < ApplicationController
  layout 'assignment'
  def new
  end

  def create
    @employee = Employee.find_by_number(params[:number])
    if @employee
      flash[:alert] = ""
      render "show"
    else
      flash[:alert] = I18n.t "messages.doesnt_exist"
      render "new"
    end
  end

  def show
  end

  def edit
    employee = Employee.find(params[:id])
    session[:employee_id] = employee.id
    flash[:notice] = I18n.t "messages.wellcome"
    redirect_to new_assignment_path
  end

  def destroy
    session[:employee_id] = nil
    flash[:alert] = I18n.t "messages.logged_out"
    redirect_to root_url
  end
end
