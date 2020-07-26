# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DEFAULT_PASSWORD_ADMIN = '123456'
DEFAULT_PASSWORD_USER = '123456'

#User.create!(email: 'user@user.com', password: DEFAULT_PASSWORD_USER, password_confirmation: DEFAULT_PASSWORD_USER)
Admin.create!(email: 'admin@admin.com', password: DEFAULT_PASSWORD_USER, password_confirmation: DEFAULT_PASSWORD_USER)

10.times do |i|
    Admin.create!(
        email: Faker::Internet.email, 
        password: DEFAULT_PASSWORD_ADMIN, 
        password_confirmation: DEFAULT_PASSWORD_ADMIN)
end

["Comida caseira", "Comida japonesa", "Comida Regional", "Lanche", "Almoço"].each do |category|
    Product::Category.find_or_create_by!(description: category)
end

["Salgados", "Molhados", "Doces", "Aperitivo"].each do |type|
    Product::Type.find_or_create_by!(description: type)
end

20.times do |i|
    Product::Product.find_or_create_by!(
        description: Faker::Food.dish,
        about: Faker::Food.description,
        price: (5..40).to_a.sample,
        product_category: Product::Category.all.sample,
        product_type: Product::Type.all.sample
    )
end