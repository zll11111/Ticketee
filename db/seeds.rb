# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User.exists?(email:"admin@ticketee.com")
  User.create!(email:"admin@ticketee.com",password:"password",admin:true)
end

unless User.exists?(email: "viewer@ticketee.com")
  User.create!(email: "viewer@ticketee.com", password: "password")
end

["Sublime Text 3", "Internet Explorer"].each do |name|
  unless Project.exists?(name: name)
    Project.create!(name: name, description: "A sample project about #{name}"
    )
  end
end

unless Role.exists?(user:User.find_by_email("viewer@ticketee.com"),role:"viewer",project:Project.find_by_name("Sublime Text 3"))
  Role.create!(user:User.find_by_email("viewer@ticketee.com"),role:"viewer",project:Project.find_by_name("Sublime Text 3"))
end