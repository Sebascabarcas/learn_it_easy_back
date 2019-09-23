class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.integer :role
      t.string :first_name
      t.string :second_name
      t.string :first_lastname
      t.string :second_lastname
      t.string :address
      t.string :phone
      t.string :cellphone

      t.timestamps
    end
  end
end
