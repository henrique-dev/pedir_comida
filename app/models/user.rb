class User < ApplicationRecord
    # Include default devise modules.
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, #:trackable
            :validatable, authentication_keys: [:telephone]
            #:confirmable, :omniauthable
    include DeviseTokenAuth::Concerns::User    

    attr_accessor  :name
    attr_accessor  :genre
    attr_accessor  :birth_date
    attr_accessor  :height
    attr_accessor  :bloodtype
    attr_accessor  :cpf
    attr_accessor  :weight
    attr_accessor  :created_by_admin

    belongs_to :user_profile, class_name: "UserProfile", optional: true, foreign_key: "user_profile_id"

    validates :telephone, presence: true, uniqueness: { case_sensitive: false }

    after_create :complete_creation
    
    def email_required?    
        false
    end  

    def complete_creation
        genres = ["m", "f"]
        bloodtypes = ["A+", "A-", "B+", "B-", "O+", "O-"]

        user_profile = UserProfile.create!(
            name: self.name,
            genre: self.genre,
            birth_date: self.birth_date,
            cpf: self.cpf,
            user: self
        )

        if !self.created_by_admin
            user_address = Address.new
            user_address.save
            user_address.save if user_profile.address = user_address
        end
        
    end
end