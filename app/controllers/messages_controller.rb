class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:destroy]
  
  def index
    @messages = current_user.messages
    @message = Message.new
  end
  
  def create
    @message = Message.new(message_params)
    @message.assign_attributes({ :user_id => current_user.id })
    respond_to do |format|
      if @message.save          
        format.js
      else
        format.js do
          render js: "alert('Cant save message');"
        end
      end
    end
  end
  
  def destroy 
    respond_to do |format|
      if !@message.destroy
         flash.now[:notice] = t("message.activerecord.errors.destroy")
      end
      format.html{ redirect_to messages_url}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:user_id, :message_text)
    end
end