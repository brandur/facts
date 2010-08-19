class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [ :new, :create ]
  before_filter :require_user, :only => :destroy

  # GET /user_sessions/new
  # GET /user_sessions/new.json
  def new
    @user_session = UserSession.new

    respond_to do |format|
      format.html 
      format.json { render :json => @user_session }
    end
  end

  # POST /user_sessions
  # POST /user_sessions.json
  def create
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      if @user_session.save
        format.html { redirect_back_or_default(user_url(@user_session.user), :notice => 'Login successful!') }
        format.json { render :json => @user_session, :status => :created, :location => @user_session }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_sessions
  # DELETE /user_sessions.json
  def destroy
    current_user_session.destroy
    respond_to do |format|
      format.html { redirect_back_or_default(new_user_session_url, :notice => 'Logout successful!') }
      format.json { head :ok }
    end
  end
end
