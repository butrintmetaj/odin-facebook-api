class CreateFriendRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests do |t|
      t.references :requester, index: true, null: false
      t.references :requestee, index: true, null: false
      t.integer :status, default: 0
      t.index [:requester_id, :requestee_id], unique: true
      t.timestamps
    end

    add_foreign_key :friend_requests, :users, column: :requester_id
    add_foreign_key :friend_requests, :users, column: :requestee_id
  end
end
