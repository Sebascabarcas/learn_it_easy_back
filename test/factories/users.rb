FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role { [0, 1].sample }
    name { Faker::Name.name }
    first_lastname { Faker::Name.last_name }
    second_lastname { Faker::Name.last_name }
    address { Faker::Address.full_address }
    phone { Faker::PhoneNumber.cell_phone }
    cellphone { Faker::PhoneNumber.cell_phone }
  end
end
