class CreateUsers < ActiveRecord::Migration

  def self.up
    create_table :users do |t|
      
      # attributes for user information
      t.string :firstname,:null => false
      t.string :middlename,:null => true
      t.string :lastname, :null => false
      
      # attributes to store omniauth information
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.datetime :oauth_expires_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
  
end
