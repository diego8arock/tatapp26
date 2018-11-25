class SessionsController < ApplicationController
  def new
  end

   def create
    user = User.find_by_employee_number(params[:employee_number])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Id Empleado o Fecha de Ingreso es invalido."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
