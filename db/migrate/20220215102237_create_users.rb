class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, index: { unique: true, name: 'unique_emails' }
      t.string :password_digest, null: false
      t.date :birthday, null: false
      t.integer :gender, default: 0
      t.timestamps
    end
  end
end


