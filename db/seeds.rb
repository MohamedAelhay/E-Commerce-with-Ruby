# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
User.create!(email: 'user@example.com', password: 'passworduser', password_confirmation: 'passworduser',username: 'user') if Rails.env.development?
  10.times do
      Brand.create([{
          name: Faker::Appliance.brand
      }])
  end

  10.times do
      Category.create([{
          name: Faker::Commerce.department(1, true)
      }])
  end

  10.times do
      Store.create([{
          user_id: 1,
          name: Faker::Company.name,
          summary: Faker::Lorem.sentence
      }])
  end

 10.times do
     Product.create([{
         brand_id: rand(1..10),
         category_id: rand(1..10),
         store_id: rand(1..10),
         title: Faker::Device.model_name,
         description: Faker::Lorem.sentence,
        
         price: Faker::Commerce.price,
         quantity: rand(1..100) 
     }])
 end
