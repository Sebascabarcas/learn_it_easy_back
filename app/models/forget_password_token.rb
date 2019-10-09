class ForgetPasswordToken < ApplicationRecord
    include SecretGenerator
    
    #Relationships
    belongs_to :user
  
    #Validations
    validates :secret, uniqueness: true
  
    #Callbacks
    before_create :generate_secret_token 
    before_create :set_expire_at_secret
end