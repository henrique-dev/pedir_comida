class PaymentCenter    

    def self.create_pagarme_card_hash(pagarme_card)        

        require 'pagarme'
        PagarMe.api_key = "ak_test_VbiowWEdoiTrDtv6afJ7xmoYquJN9a"

        card = PagarMe::Card.new({
            :card_number => pagarme_card.card_number.gsub(" ", ""),
            :card_holder_name => pagarme_card.card_holder_name,
            :card_expiration_month => pagarme_card.card_expiration_date[0,2],
            :card_expiration_year => pagarme_card.card_expiration_date[3,4],
            :card_cvv => pagarme_card.card_cvv
        })

        card.create
    end

    def self.create_pagarme_transaction
        require 'pagarme'
        PagarMe.api_key = "ak_test_VbiowWEdoiTrDtv6afJ7xmoYquJN9a"

        require 'pagarme'

        transaction  = PagarMe::Transaction.new({
            amount: 100,
            card_id: "",
            payment_method: "credit_card",
            postback_url: "http://requestb.in/pkt7pgpk",
            customer: {
                external_id: "#3311",
                name: "Morpheus Fishburne",
                type: "individual",
                country: "br",
                email: "mopheus@nabucodonozor.com",
                documents: [
                {
                    type: "cpf",
                    number: "30621143049"
                }
                ],
                phone_numbers: ["+5511999998888", "+5511888889999"],
                birthday: "1965-01-01"
            },
            billing: {
                name: "Trinity Moss",
                address: {
                country: "br",
                state: "sp",
                city: "Cotia",
                neighborhood: "Rio Cotia",
                street: "Rua Matrix",
                street_number: "9999",
                zipcode: "06714360"
                }
            },
            shipping: {
                name: "Neo Reeves",
                fee: 1000,
                delivery_date: "2000-12-21",
                expedited: true,
                address: {
                  country: "br",
                  state: "sp",
                  city: "Cotia",
                  neighborhood: "Rio Cotia",
                  street: "Rua Matrix",
                  street_number: "9999",
                  zipcode: "06714360"
                }
            },
            items: [
                {
                  id: "r123",
                  title: "Red pill",
                  unit_price: 10000,
                  quantity: 1,
                  tangible: true
                },
                {
                  id: "b123",
                  title: "Blue pill",
                  unit_price: 10000,
                  quantity: 1,
                  tangible: true
                }
              ]
            })
        transaction.charge
    end

end