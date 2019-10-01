class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.string :secret
      t.date :expire_at
      t.integer :user_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
