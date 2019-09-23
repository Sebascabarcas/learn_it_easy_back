require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'validations' do
    it 'validate presence of required fields' do
      should validate_presence_of(:email)
      should validate_presence_of(:password)
      should validate_presence_of(:role)
      should validate_presence_of(:first_name)
      should validate_presence_of(:second_name)
      should validate_presence_of(:first_latname)
      should validate_presence_of(:second_lastname)
    end
  end
end
