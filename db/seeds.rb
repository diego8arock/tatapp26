# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
#Roles
Role.create(name: :admin)
Role.create(name: :employee)

#Projects
project1 = Project.create(name: 'Grupo Soporte', status: '1', tag: 'GS')
project2 = Project.create(name: 'Claro/Telmex', status: '1', tag: 'CL')
project3 = Project.create(name: 'Davivienda', status: '1', tag: 'DA')
project4 = Project.create(name: 'ABINBEV', status: '1', tag: 'AB')
project5 = Project.create(name: 'AVIANCA', status: '1', tag: 'AV')
project6 = Project.create(name: 'Retail SWON', status: '1', tag: 'RE')
project7 = Project.create(name: 'BFSI SWON', status: '1', tag: 'BF')
project8 = Project.create(name: 'ENTSOL', status: '1', tag: 'EN')
project9 = Project.create(name: 'SWON CMI', status: '1', tag: 'SW')
project10 = Project.create(name: 'Compliance SWON', status: '1', tag: 'CO')
project11 = Project.create(name: 'TIGO', status: '1', tag: 'TI')

#User admin
user1 = User.create(username: 'admin',
				    password: 'password1234',
				    password_confirmation: 'password1234')
user1.add_role(:admin)

case Rails.env
when 'development'

	#User employees
	user2 = User.create(username: '1',
					    password: '123456',
					    password_confirmation: '123456')
	user2.add_role(:employee)

	user3 = User.create(username: '2',
					    password: '123456',
					    password_confirmation: '123456')
	user3.add_role(:employee)

	user3 = User.create(username: '3',
					    password: '123456',
					    password_confirmation: '123456')
	user3.add_role(:employee)

	user4 = User.create(username: '4',
					    password: '123456',
					    password_confirmation: '123456')
	user4.add_role(:employee)

	#Employees

	employee1 = Employee.create(number: '1',
		name: 'Julio Pinzon',
		birth_date: '1984-10-06',
		admission_date: '2017-05-22',
		status: 1,
		assignment_type: 1)

	employee2 = Employee.create(number: '2',
		name: 'Diego Ochoa',
		birth_date: '1989-12-11',
		admission_date: '2017-05-22',
		status: 1,
		assignment_type: 1)

	employee3 = Employee.create(number: '3',
		name: 'Paola Bernal',
		birth_date: '1989-12-11',
		admission_date: '2017-05-22',
		status: 1,
		assignment_type: 1)

	employee4 = Employee.create(number: '4',
		name: 'Paola Cardenas',
		birth_date: '1989-12-11',
		admission_date: '2017-05-22',
		status: 1,
		assignment_type: 1)

	#Project employee
	ProjectEmployee.create(
		employee: employee1,
		project: project1,
		status: 1
		)
	ProjectEmployee.create(
		employee: employee2,
		project: project1,
		status: 1
		)
	ProjectEmployee.create(
		employee: employee3,
		project: project2,
		status: 1
		)
	ProjectEmployee.create(
		employee: employee4,
		project: project2,
		status: 1
		)
	
end
end