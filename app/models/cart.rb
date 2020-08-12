class Cart < ApplicationRecord
    after_find :set_total

    attr_accessor :products
    attr_accessor :taxes

    has_one :order_checkout, dependent: :destroy, class_name: "Checkout"
    belongs_to :user_profile, optional: true, class_name: "UserProfile"

    def add hash_items
        if !self.locked
            if !self.items
                hash_items[:sub_id] = self.sub_id_increment
                self.items = [hash_items]
                self.sub_id_increment += 1
                return {success: true}
            else
                hash_items[:sub_id] = self.sub_id_increment
                self.items << hash_items
                self.sub_id_increment += 1
                return {success: true}
            end
        else
            return {success: false, control: "locked"}
        end
    end

    def update hash_items
        if !self.locked
            index = self.items.index {|i| i["product_id"] == hash_items[:product_id] && i["sub_id"] == hash_items[:sub_id]}
            self.items[index] = hash_items
            return {success: true}
        else
            return {success: false, controle: "locked"}
        end
    end

    def remove id, sub_id
        if (self.items && self.items.length > 0)
            item = self.items.delete_if {|i| i["product_id"] == id && i["sub_id"] == sub_id}
        end
        return "success"
    end

    def checkout params
        user_profile = self.user_profile
        payment = {}
        if params[:payment_type] == "physical"
            payment = user_profile.payment.payment_physicals.find(params[:payment_id])
        end

        payment = user_profile.payment.payment_physicals.find(params[:payment_id])        

        if (params[:address_id] > 0 && address = user_profile.addresses.find(params[:address_id]))
            set_total(params[:address_id])

            self.locked = true
            checkout = Checkout.new
            checkout.cart = self
            checkout.address = address
            checkout.user_profile = user_profile
            checkout.payment_method = payment
            if !checkout.save
                self.locked = false
                self.sub_id_increment = 1
                self.save
                return "error"
            end
            self.save
            return "success"
        else
            return "address_not_found"
        end
    end

    def repurchase order_id
        if !self.locked
            order = Order.find(order_id)
            if order
                array_products = []
                order.items["items"].each do |item|
                    hash_product = {}
                    if Product::Product.find(item["product_id"])
                        hash_product[:product_id] = item["product_id"]
                        hash_product[:sub_id] = self.sub_id_increment
                        self.sub_id_increment += 1
                        hash_product[:quantity] = item["quantity"]

                        hash_product[:complements] = []
                        hash_product[:variations] = []
                        hash_product[:ingredients] = []
                        if item["complements"]
                            item["complements"].each do |id|
                                if Product::Complement.find(id)
                                    hash_product[:complements] << id
                                end
                            end
                        end
                        if item["variations"]
                            item["variations"].each do |id|
                                if Product::Variation.find(id)
                                    hash_product[:variations] << id
                                end
                            end
                        end
                        if item["ingredients"]
                            item["ingredients"].each do |id|
                                if Product::Ingredient.find(id)
                                    hash_product[:ingredients] << id
                                end
                            end
                        end              
                        array_products << hash_product
                    end
                end 
                if self.items
                    self.items += array_products
                else
                    self.items = array_products
                end
                return {success: true}
            end
            return {success: false}
        else
            return {success: false, control: "locked"}
        end
    end

    def set_total (address_id = nil)
        neighborhoods_tax = {
            "Alvorada" => 5,
            "Araxá" => 6,
            "Beirol" => 7,
            "Boné Azul" => 8,
            "Brasil Novo" => 5,
            "Buritizal" => 4,
            "Cabralzinho" => 3,
            "Central" => 2,
            "Cidade Nova" => 1,
            "Congós" => 6,
            "Infraero" => 10,
            "Jardim Equatorial" => 11,
            "Jardim Felicidade" => 12,
            "Jesus de Nazaré" => 23,
            "Laguinho" => 2,
            "Marco Zero" => 10,
            "Nova Esperança" => 20,
            "Novo Buritizal" => 30,
            "Novo Horizonte" => 5,
            "Pacoval" => 7,
            "Pedrinhas" => 9,
            "Perpétuo Socorro" => 10,
            "Santa Inês" => 11,
            "Santa Rita" => 12,
            "São Lázaro" => 5,
            "Trem" => 7,
            "Universidade" => 7,
            "Zerão" => 10
        }
        self.taxes = neighborhoods_tax
        default_address = nil
        if address_id
            default_address = self.user_profile.addresses.find(address_id)
            self.current_address_id = address_id
        else
            if self.current_address_id
                default_address = self.user_profile.addresses.find(self.current_address_id)
            else
                default_address = self.user_profile.addresses.where(default: true).first
            end
        end        
        self.total = 0
        if default_address && self.items && self.items.count > 0            
            self.total = neighborhoods_tax[default_address.neighborhood]
        end        
        if self.items
            self.items.each do |item|
                product = Product::Product.find(item["product_id"])
                total_product = product.price
                if item["complements"]
                    item["complements"].each do |id|
                        complement = Product::Complement.find(id)
                        total_product += complement.price
                    end
                end
                if item["variations"]
                    item["variations"].each do |id|
                        variation = Product::Variation.find(id)
                        total_product += variation.price
                    end
                end
                if item["ingredients"]
                    item["ingredients"].each do |id|
                        ingredient = Product::Ingredient.find(id)
                        total_product -= ingredient.price
                    end
                end
                self.total += (total_product * item["quantity"])
            end
        end
        self.save
    end

    def load_products 
        self.total = 0       
        if self.items
            self.products = []
            self.items.each do |item|
                product = Product::Product.find(item["product_id"])
                product.sub_id = item["sub_id"]
                product.quantity = item["quantity"]
                product.complements = []
                product.ingredients = []
                product.variations = []

                total_product = product.price

                if item["complements"]
                    item["complements"].each do |id|
                        complement = Product::Complement.find(id)
                        product.complements << complement

                        total_product += complement.price
                    end
                end
                if item["variations"]
                    item["variations"].each do |id|
                        variation = Product::Variation.find(id)
                        product.variations << variation

                        total_product += variation.price
                    end
                end
                if item["ingredients"]
                    item["ingredients"].each do |id|
                        ingredient = Product::Ingredient.find(id)
                        product.ingredients << ingredient

                        total_product -= ingredient.price
                    end
                end
                self.total += (total_product * item["quantity"])

                self.products << product
            end
        end
        self.save
    end
end
