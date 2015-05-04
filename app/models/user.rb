class User < ActiveRecord::Base
 
 after_create :add_welcome_message
  
  def add_welcome_message
    messages.build(:message_text => I18n.t("message.activerecord.first_message")).save
  end
  
 validates :firstname, :lastname, 
  :presence => :true, :on => :create
   
 has_many :messages, :dependent => :destroy
 accepts_nested_attributes_for :messages
 
  # Devise module for using Google omniauth
  devise :database_authenticatable, :registerable,
    :trackable, :validatable, :omniauthable,
    :omniauth_providers => [:google_oauth2]
         
  def self.google_access_fields(auth = {})    
    { 
      :oauth_token => auth.credentials.token,
      :oauth_expires_at => Time.at(auth.credentials.expires_at) 
    }
  end  
  
  def self.from_google_omniauth(auth)
    
    auth_email = auth.extra.raw_info.email
      
    auth_user = where(email: auth_email).first_or_initialize do |user|     
        
      if auth.info.first_name
        user.firstname = auth.info.first_name
      end
      if auth.info.last_name
        user.lastname = auth.info.last_name 
      end
  
      user.uid = auth.uid
      user.provider = auth.provider   
      user.password = Devise.friendly_token[0,20]    
      user.save!
    end
      
    auth_user.update_attributes(google_access_fields auth)
    return auth_user
  end  
         
end
