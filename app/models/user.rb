class User < ApplicationRecord
    # Include default devise modules.
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, #:trackable
            :validatable,# authentication_keys: [:telephone]
            :confirmable, authentication_keys: [:telephone]
            #, :omniauthable
    include DeviseTokenAuth::Concerns::User    

    attr_accessor  :name
    attr_accessor  :genre
    attr_accessor  :birth_date    
    attr_accessor  :cpf
    attr_accessor  :created_by_admin

    belongs_to :user_profile, class_name: "UserProfile", optional: true, foreign_key: "user_profile_id"
    
    validates :telephone, presence: true, uniqueness: { case_sensitive: false }

    after_create :complete_creation
    
    def email_required?    
        false
    end

    def email_changed? 
        false 
    end 

    def generate_confirmation_token
        if self.confirmation_token && !confirmation_period_expired?
            @raw_confirmation_token = self.confirmation_token
        else
            self.confirmation_token = @raw_confirmation_token = Devise.friendly_token(6).upcase
            self.confirmation_sent_at = Time.now.utc
        end
    end

    def unconfirmed_email        
    end

    def send_confirmation_instructions(args)
    end

    def send_on_create_confirmation_instructions
    end

    def self.confirm_token params
        user = User.find_by(telephone: params[:telephone], confirmation_token: params[:confirmation_token])        
        if user && !user.confirmed?
            if ((DateTime.now.to_time - user.confirmation_sent_at.to_time) / 1.hours < 8)
                user.confirmed_at = DateTime.now
                user.save
                return {:status => "success", :message => ""}
            else
                return {:status => "token_outdated", :message => "O token não é mais válido"}
            end
        else
            if user.confirmed?
                return {:status => "success", :message => ""}
            end
        end        
    end

    def send_confirmation_token
        require 'twilio-ruby'

        account_sid = "AC3d4416535a462a996a081251985f1094" # Your Test Account SID from www.twilio.com/console/settings
        auth_token = "05fa8c5e7f6df0166287430633645864"   # Your Test Auth Token from www.twilio.com/console/settings

        @client = Twilio::REST::Client.new account_sid, auth_token
        message = @client.messages.create(
            body: "Insira o código #{self.confirmation_token} para confirmar a criação de sua conta",
            to: "+5596991100443",    # Replace with your phone number
            from: "+12084178988")  # Use this Magic Number for creating SMS
    end

    def complete_creation

        user_profile = UserProfile.create!(
            name: self.name,
            user: self
        )

        if !self.created_by_admin
            user_address = Address.new
            user_address.save
            user_address.save if user_profile.addresses << user_address
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
        
    end

    def self.check_telephone telephone
        if (User.find_by(telephone: telephone))
            return {:control => "exists", :can_login => true}
        else
            return {:control => "not_exists", :can_login => true}
        end
    end

end