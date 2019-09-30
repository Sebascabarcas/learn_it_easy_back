require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validate presence of required fields' do
      should validate_presence_of(:email)
      # should validate_presence_of(:password)
      should validate_presence_of(:role)
      should validate_presence_of(:name)
      should validate_presence_of(:first_lastname)
      should validate_presence_of(:second_lastname)
    end
  end
end
