# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DEFAULT_PASSWORD_ADMIN = 'ZXDas7966PHD26@@head2020'
DEFAULT_PASSWORD_USER = '123456'
GENRES = ["m", "f"]

#User.create!(email: 'user@user.com', password: DEFAULT_PASSWORD_USER, password_confirmation: DEFAULT_PASSWORD_USER)
Admin.create!(email: 'admin@admin.com', password: DEFAULT_PASSWORD_ADMIN, password_confirmation: DEFAULT_PASSWORD_ADMIN)

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

Faker::UniqueGenerator.clear

20.times do |i|
    product = Product::Product.find_or_create_by!(
        name: Faker::Food.unique.dish,
        description: Faker::Food.description,
        price: "#{(5..40).to_a.sample}.#{(0..9).to_a.sample}0",
        product_category: Product::Category.all.sample,
        product_type: Product::Type.all.sample        
    )

    (1..3).to_a.sample.times do |j|
        Product::Complement.find_or_create_by!(
            name: Faker::Food.unique.fruits,
            description: Faker::Food.description,
            price: "#{(1..5).to_a.sample}.#{(0..9).to_a.sample}0",
            product_product: product
        )
    end

    (1..3).to_a.sample.times do |j|
        Product::Ingredient.find_or_create_by!(
            name: Faker::Food.unique.ingredient,
            description: Faker::Food.description,
            price: "#{(1..5).to_a.sample}.#{(0..9).to_a.sample}0",
            product_product: product
        )
    end

    (1..3).to_a.sample.times do |j|
        Product::Variation.find_or_create_by!(
            name: Faker::Food.unique.spice,
            description: Faker::Food.description,
            price: "#{(1..5).to_a.sample}.#{(0..9).to_a.sample}0",
            product_product: product
        )
    end

    product.min_complements = (1..(product.product_complements.count)).to_a.sample
    product.max_complements = (product.min_complements..(product.product_complements.count)).to_a.sample    
    product.max_ingredients = (1..(product.product_ingredients.count)).to_a.sample
    product.min_variations = (1..(product.product_variations.count)).to_a.sample
    product.max_variations = (product.min_variations..(product.product_variations.count)).to_a.sample

    product.save
end

user = User.create!(
    telephone: "96991100443",
    password: DEFAULT_PASSWORD_USER, 
    password_confirmation: DEFAULT_PASSWORD_USER,
    #email: Faker::Internet.email,
    uid: "96991100443",
    provider: "telephone",
    created_by_admin: true,
    name: Faker::Name.name,
    genre: GENRES[[0,1].sample],
    birth_date: Faker::Date.between(from: '1960-09-23', to: Date.today),
    cpf: Faker::Number.leading_zero_number(digits: 12))

user_profile = user.user_profile

default_address = false

(1..4).to_a.sample.times do |i|
    user_address = Address.create!(
        description: "Minha casa #{i}",
        street: Faker::Address.street_name,
        number: Faker::Address.building_number,
        zipcode: Faker::Address.zip,
        state: Faker::Address.state,
        country: Faker::Address.country,
        city: Faker::Address.city,
        neighborhood: Faker::Address.community,
        default: (!default_address ? true : false),
        user_profile: user_profile
    )
    default_address = true
end

payment = Payment.create!(
    user_profile: user_profile
)

payment_physical = Payment::Physical.create!(
    payment_type: "physical",
    payment_type2: "credit_card",
    name: "Cartão de cŕedito",
    description: "Pagamento no ato da entrega com cartão de crédito",
    payment: payment
)
payment_physical = Payment::Physical.create!(
    payment_type: "physical",
    payment_type2: "debit_card",
    name: "Cartão de débito",
    description: "Pagamento no ato da entrega com cartão de débito",
    payment: payment
)
payment_physical = Payment::Physical.create!(
    payment_type: "physical",
    payment_type2: "money",
    name: "Dinheiro",
    description: "Pagamento no ato da entrega com dinheiro",
    default: true,
    payment: payment
)

cart = Cart.create!(
    user_profile: user_profile
)

10.times do |i|
    user = User.create!(
        telephone: Faker::PhoneNumber.cell_phone_in_e164,
        password: DEFAULT_PASSWORD_USER, 
        password_confirmation: DEFAULT_PASSWORD_USER,
        email: Faker::Internet.email,
        provider: "email",
        created_by_admin: true,

        name: Faker::Name.name,
        genre: GENRES[[0,1].sample],
        birth_date: Faker::Date.between(from: '1960-09-23', to: Date.today),
        cpf: Faker::Number.leading_zero_number(digits: 12))
    
    user_profile = user.user_profile

    user_address = Address.create!(
        description: "Minha casa #{i}",
        street: Faker::Address.street_name,
        number: Faker::Address.building_number,
        zipcode: Faker::Address.zip,
        state: Faker::Address.state,
        country: Faker::Address.country,
        city: Faker::Address.city,
        neighborhood: Faker::Address.community,
        default: true,
        user_profile: user_profile
    )

    cart = Cart.create!(
        user_profile: user_profile
    )

    #user_profile.save if user_profile.address = user_address
end