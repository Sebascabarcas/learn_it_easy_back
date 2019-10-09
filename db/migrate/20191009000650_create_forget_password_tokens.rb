class CreateForgetPasswordTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :forget_password_tokens do |t|
      t.string :secret
      t.references :user, null: false, foreign_key: true
      t.datetime :expire_at

      t.timestamps
    end
  end
end
