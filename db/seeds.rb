# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
        brand_id: 20,
        category_id: 10,
        store_id: 1,
        title: Faker::Device.model_name,
        description: Faker::Lorem.sentence,
        image: Faker::Avatar.image("my-own-slug", "50x50", "jpg"),
        price: Faker::Commerce.price,
        quantity: 10    
    }])
end