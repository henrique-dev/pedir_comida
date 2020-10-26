class Payment::Pagarme < ApplicationRecord
    attr_accessor :card_number
    attr_accessor :card_holder_name
    attr_accessor :card_expiration_date
    attr_accessor :card_cvv
    attr_accessor :payment_center_type

    belongs_to :payment, optional: true

    def create_pagarme_credit_card
        if card = PaymentCenter.create_pagarme_card_hash(self)        
            self.card_id = card.id
            self.description = "XXXX XXXX XXXX #{card.last_digits}"
            self.brand = card.brand
            self.holder_name = card.holder_name
            self.payment_type = "virtual"
            self.payment_type2 = "credit_card"
            self.name = "Cartão de cŕedito"
            self.sub_description = "Terminado em #{card.last_digits}"
            self.sub_description2 = "Pagamento virtual com cartão de crédito terminado em #{card.last_digits}"
            return true
        end
        false
    end

end