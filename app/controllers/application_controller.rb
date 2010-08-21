class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  helper :all
  helper_method :current_user_session, :current_user

  private

  def authorized?(obj)
    current_user && obj.user_id == current_user.id
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def authenticated_with_params?
    if params[:login] && params[:password]
      user_session = UserSession.create(:login => params[:login], :password => params[:password])
      @current_user_session, @current_user = user_session, user_session.record if user_session.valid?
      true
    end
  end

  def require_user
    unless current_user || authenticated_with_params?
      if params[:login]
        puts "authenticated_Wth_params = #{authenticated_with_params?}"
      end
      store_location
      flash[:notice] = 'You must be logged in to access this page'
      redirect_to(new_user_session_url)
      false
    else
      puts 'ACCESS GRANTED'
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = 'You must be logged out to access this page'
      redirect_to(account_url)
      false
    end
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default, msgs = {})
    msgs.each{ |k, v| flash[k] = v }
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  class SaveError < RuntimeError
  end

  class UnauthorizedError < RuntimeError
  end
end
