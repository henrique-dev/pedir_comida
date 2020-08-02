# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DEFAULT_PASSWORD_ADMIN = '123456'
DEFAULT_PASSWORD_USER = '123456'
GENRES = ["m", "f"]

#User.create!(email: 'user@user.com', password: DEFAULT_PASSWORD_USER, password_confirmation: DEFAULT_PASSWORD_USER)
Admin.create!(email: 'admin@admin.com', password: DEFAULT_PASSWORD_USER, password_confirmation: DEFAULT_PASSWORD_USER)

10.times do |i|
    Admin.create!(
        email: Faker::Internet.email, 
        password: DEFAULT_PASSWORD_ADMIN, 
        password_confirmation: DEFAULT_PASSWORD_ADMIN)
end

["Comida caseira", "Comida japonesa", "Comida Regional", "Lanche", "Almoço"].each do |category|
    Product::Category.find_or_create_by!(name: category)
end

["Salgados", "Molhados", "Doces", "Aperitivo"].each do |type|
    Product::Type.find_or_create_by!(name: type)
end

20.times do |i|
    Product::Product.find_or_create_by!(
        name: Faker::Food.dish,
        description: Faker::Food.description,
        price: (5..40).to_a.sample,
        product_category: Product::Category.all.sample,
        product_type: Product::Type.all.sample
    )
end

10.times do |i|
    user = User.create!(
        telephone: Faker::PhoneNumber.cell_phone_in_e164,
        password: DEFAULT_PASSWORD_ADMIN, 
        password_confirmation: DEFAULT_PASSWORD_ADMIN,
        email: Faker::Internet.email,
        provider: "email",

        name: Faker::Name.name,
        genre: GENRES[[0,1].sample],
        birth_date: Faker::Date.between(from: '1960-09-23', to: Date.today),
        cpf: Faker::Number.leading_zero_number(digits: 12))
    
    user_profile = user.user_profile

    user_address = Address.create!(
        street: Faker::Address.street_name,
        number: Faker::Address.building_number,
        zipcode: Faker::Address.zip,
        state: Faker::Address.state,
        country: Faker::Address.country,
        city: Faker::Address.city,
        neighborhood: Faker::Address.community
    )

    user_profile.save if user_profile.address = user_address
end