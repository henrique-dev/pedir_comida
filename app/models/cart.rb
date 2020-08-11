class Cart < ApplicationRecord
    after_find :set_total

    attr_accessor :products

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
            return {success: false, controle: "locked"}
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

    def set_total
        self.total = 0
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
