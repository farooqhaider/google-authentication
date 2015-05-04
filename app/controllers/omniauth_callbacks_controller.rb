class OmniauthCallbacksController < Devise::OmniauthCallbacksController   
  
  def google_oauth2
    omniauth_params = request.env['omniauth.auth']
    logger.debug "omniauth_params #{omniauth_params}"
   
    user = User.from_google_omniauth(omniauth_params)
    
    if (!user.nil? && user.persisted?)
      session[:user_id] = user.id  
      sign_in user, :bypass => true, notice: "Successfully created user by google"
      redirect_to messages_url
    else
      redirect_to root_url
    end
      
  end
  
end