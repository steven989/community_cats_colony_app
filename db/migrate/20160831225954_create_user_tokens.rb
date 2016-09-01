class CreateUserTokens < ActiveRecord::Migration
  def change
    create_table :user_tokens do |t|
        t.string :email
        t.string :token
        t.string :role
      t.timestamps null: false
    end
  end
end
