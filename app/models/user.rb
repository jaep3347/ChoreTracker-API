class User < ApplicationRecord
    has_secure_password
  
    validates_presence_of :email
    validates_uniqueness_of :email, allow_blank: true
    validates_presence_of :password, on: :create 
    validates_presence_of :password_confirmation, on: :create 
    validates_confirmation_of :password, message: "does not match"
    validates_length_of :password, minimum: 4, message: "must be at least 4 characters long", allow_blank: true

    before_create :generate_api_key

    # login by email address
    def self.authenticate(email, password)
      find_by_email(email).try(:authenticate, password)
    end

    def generate_api_key
      begin
        self.api_key = SecureRandom.hex
      end while User.exists?(api_key: self.api_key)
    end
    
end