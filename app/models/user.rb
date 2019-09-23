class User < ApplicationRecord
  #Enums
  enum role: {admin: 0, client: 1}
	
	#Validations
	validates :first_name, :second_name, :first_lastname, :second_lastname, :email, :role, presence: true



end
