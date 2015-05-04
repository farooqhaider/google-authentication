class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
     
      t.integer :user_id
      t.text :message_text
      
      t.timestamps
    end
    # Add foreign keys
    add_foreign_key :messages, :users, :column => "user_id"
  end
  
  def self.down
    drop_table :messages
  end
end
