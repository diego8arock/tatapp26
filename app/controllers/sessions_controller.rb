class SessionsController < ApplicationController
  def new
  end

  def create
    @employee = Employee.find_by_number(params[:number])
    if @employee
      render "show"
    else
      flash[:alert] = "Employee number doesn't exists"
      render "new"
    end
  end

  def show
  end

  def edit
    employee = Employee.find(params[:id])
    session[:employee_id] = employee.id
    flash[:info] = "Welcome to the App26!"
    redirect_to "/assignments#index"
  end

  def destroy
    session[:employee_id] = nil
    flash[:alert] = "Logged out!"
    redirect_to root_url
  end
end
