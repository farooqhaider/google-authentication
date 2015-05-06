class Message < ActiveRecord::Base
  
  belongs_to :user 
  
  validates :message_text, presence: true
   
  scope :recent_messages, 
    ->(id) { where(:user_id => id).order("created_at DESC")}

end
