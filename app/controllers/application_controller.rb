class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  helper :all

  private

  helper_method :authorized?
  def authorized?(obj)
    current_user && obj.user_id == current_user.id
  end

  helper_method :current_user_session
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  helper_method :current_user
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    case request.format
    when Mime::HTML
      unless current_user
        store_location
        flash[:notice] = 'You must be logged in to access this page'
        redirect_to(new_user_session_url)
        false
      end
    else
      authenticate_or_request_with_http_basic do |username, password|
        user_session = UserSession.create(:login => username, :password => password)
        user_session.valid?
      end
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
