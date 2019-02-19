class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  layout 'admin'

# GET
  def assignments
  	@assignments = nil
  	@from_date = Date.today
  	@to_date = Date.today
  	if params[:from_date]
	  	@from_date = params[:from_date].to_date
	  	@to_date = params[:to_date].to_date
  		@assignments = Assignment.search(@from_date, @to_date)
  	end
=begin
  	Select e.number as 'Numero empleado', e.name as 'Nombre', 
	p.name as 'Proyecto', a.assignment_date as 'Fecha asignacion', s.code as 'Numero puesto' 
	from assignments a 
	join employees e on a.employee_id=e.id
	join projects p on a.project_id=p.id
	join seats s on a.seat_id=s.id
	where a.assignment_date >= '2019-02-08' and a.status = 1
	order by a.assignment_date
=end
	respond_to do |format|
	  format.html
	  #format.csv { send_data @products.to_csv }
	  format.xlsx {render :layout => false, xlsx: 'assignments',filename: "assigments_report.xlsx"}
	end
  end
end
