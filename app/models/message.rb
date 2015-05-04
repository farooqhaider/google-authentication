class Message < ActiveRecord::Base
  
  belongs_to :user 
  
  validates :message_text, presence: true
   
  scope :recent_messages, 
    ->(user_id) { find_by_user_id(user_id).sort_by(:created_at)}

end
