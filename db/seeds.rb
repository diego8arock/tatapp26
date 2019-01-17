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
project1 = Project.create(name: 'Grupo Soporte', status: '1', tag: 'GS', colour: 'c55a11')
project2 = Project.create(name: 'Claro/Telmex', status: '1', tag: 'CL', colour: 'ffd966')
project3 = Project.create(name: 'Davivienda', status: '1', tag: 'DA', colour: 'ffff00')
project4 = Project.create(name: 'ABINBEV', status: '1', tag: 'AB', colour: 'ed7d31')
project5 = Project.create(name: 'AVIANCA', status: '1', tag: 'AV', colour: '5b9bd5')
project6 = Project.create(name: 'Retail SWON', status: '1', tag: 'RE', colour: '002060')
project7 = Project.create(name: 'BFSI SWON', status: '1', tag: 'BF', colour: '7030a0')
project8 = Project.create(name: 'ENTSOL', status: '1', tag: 'EN', colour: 'ffffff')
project9 = Project.create(name: 'SWON CMI', status: '1', tag: 'SW', colour: 'ffffff')
project10 = Project.create(name: 'Compliance SWON', status: '1', tag: 'CO', colour: 'ffffff')
project11 = Project.create(name: 'TIGO', status: '1', tag: 'TI', colour: 'a9d18e')

#User admin
user1 = User.create(username: 'admin',
				    password: 'password1234',
				    password_confirmation: 'password1234')
user1.add_role(:admin)

case Rails.env
when 'development'

	#User employees
	user2 = User.create(username: '1111111',
					    password: '123456',
					    password_confirmation: '123456')
	user2.add_role(:employee)

	user3 = User.create(username: '2222222',
					    password: '123456',
					    password_confirmation: '123456')
	user3.add_role(:employee)

	user4 = User.create(username: '3333333',
					    password: '123456',
					    password_confirmation: '123456')
	user4.add_role(:employee)

	user5 = User.create(username: '4444444',
					    password: '123456',
					    password_confirmation: '123456')
	user5.add_role(:employee)

	#Employees

	employee1 = Employee.create(number: user2.username,
		name: 'Julio Pinzon',
		birth_date: '1984-10-06',
		admission_date: '2017-05-22',
		status: 1,
		assignment_type: 1,
		project: project1)

	employee2 = Employee.create(number: user3.username,
		name: 'Diego Ochoa',
		birth_date: '1989-12-11',
		admission_date: '2017-05-22',
		status: 1,
		assignment_type: 1,
		project: project1)

	employee3 = Employee.create(number: user4.username,
		name: 'Paola Bernal',
		birth_date: '1989-12-11',
		admission_date: '2017-05-22',
		status: 1,
		assignment_type: 1,
		project: project2)

	employee4 = Employee.create(number: user5.username,
		name: 'Paola Cardenas',
		birth_date: '1989-12-11',
		admission_date: '2017-05-22',
		status: 1,
		assignment_type: 1,
		project: project2)
end
end
