class User < ApplicationRecord
  has_secure_password
  include FieldFormatter
  #Enums
  enum role: { student: 0, teacher: 1 }

  #Validations
  validates :names,
            :first_lastname,
            :second_lastname,
            :email,
            :role,
            :password,
            presence: true
  # validates :email, uniqueness: true
  # validates :email, format: {with: /\A(^\S+)[@](\w+)(\.[a-zA-Z0-9]+)+\z/}
  # validate_enum_attribute :role, message: 'role invalido'

  # #Callbacks
  # before_validation -> { strip_and_downcase_in_ram(:first_name) }
  # before_validation -> { strip_and_downcase_in_ram(:second_name) }
  # before_validation -> { strip_and_downcase_in_ram(:first_lastname) }
  # before_validation -> { strip_and_downcase_in_ram(:second_lastname) }

  scope :teachers, -> { where(role: 1) } 
  scope :students, -> { where(role: 2) } 
end
