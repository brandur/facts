class UsersController < ApplicationController
  #before_filter :require_no_user, :only => [ :new, :create ]
  #before_filter :require_user, :only => [ :edit, :update ]
  before_filter :require_user, :except => :show

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find_by_login(params[:id])
    raise ActiveRecord::RecordNotFound unless @user
    limit = params[:limit] || 10
    @recent_facts = @user.facts.order('created_at DESC').limit(limit).includes(:category)

    respond_to do |format|
      format.html
      format.json do
        stats = {}
        stats[:facts_by_day] = Hash[@user.facts.where('facts.created_at > ?', 30.days.ago.to_date).group_by{ |f| f.created_at.to_date }.map{ |day, facts| [ day.iso8601, facts.count ] }]
        render :json => { :user => @user.to_json, :recent_facts => @recent_facts.collect{ |f| f.to_json }, :stats => stats  }.to_json
      end
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = @current_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'Account registered!') }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = @current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'Account updated!') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end
