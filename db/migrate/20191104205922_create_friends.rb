class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :confirmed

      t.timestamps
    end
  end
end
