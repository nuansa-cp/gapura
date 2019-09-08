# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }
Dir[File.join(Rails.root, 'db', 'seeds', Rails.env, '*.rb')].sort.each { |seed| load seed }
usr = User.create(username:'francisco', password:'123', email:'chensanfrancisco@gmail.com', confirmed_at:DateTime.now)
usr.add_role :admin
usr.add_role :superuser