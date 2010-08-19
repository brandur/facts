class FactsController < ApplicationController
  before_filter :require_user, :only => [ :create, :destroy, :edit, :new, :update ]
  skip_before_filter :verify_authenticity_token
  set_tab :facts

  # GET /facts
  # GET /facts.json
  def index
    @facts = Fact.all :include => :category

    respond_to do |format|
      format.html # index.html.haml
      format.json  { render :json => @facts }
    end
  end

  # GET /facts/1
  # GET /facts/1.json
  def show
    @fact = Fact.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json  { render :json => @fact }
    end
  end

  # GET /facts/new
  # GET /facts/new.json
  def new
    @fact = Fact.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render :json => @fact }
    end
  end

  # GET /facts/1/edit
  def edit
    @fact = Fact.find(params[:id])
  end

  # POST /facts
  # POST /facts.json
  def create
    @fact = Fact.new(params[:fact])

    respond_to do |format|
      begin
        raise UnauthorizedError unless authorized?(@fact.category)
        raise SaveError unless @fact.save

        format.html { redirect_to(@fact, :notice => 'Fact was successfully created.') }
        format.json { render :json => @fact, :status => :created, :location => @fact }
      rescue SaveError
        format.html { render :action => "new" }
        format.json { render :json => @fact.errors, :status => :unprocessable_entity }
      rescue UnauthorizedError
        format.html { redirect_to(facts_url, :notice => 'Fact category must be owned by you.') }
        format.json { head :unauthorized }
      end
    end
  end

  # PUT /facts/1
  # PUT /facts/1.json
  def update
    @fact = Fact.find(params[:id], :include => :category)

    respond_to do |format|
      begin
        raise UnauthorizedError unless authorized? @fact.category 
        raise SaveError unless @fact.update_attributes(params[:fact])

        format.html { redirect_to(@fact, :notice => 'Fact was successfully updated.') }
        format.json { head :ok }
      rescue SaveError
        format.html { render :action => "edit" }
        format.json { render :json => @fact.errors, :status => :unprocessable_entity }
      rescue UnauthorizedError
        format.html { redirect_to(facts_url, :notice => 'No update rights to a fact not owned by you.') }
        format.json { head :unauthorized }
      end
    end
  end

  # DELETE /facts/1
  # DELETE /facts/1.json
  def destroy
    @fact = Fact.find(params[:id], :include => :category)

    respond_to do |format|
      begin
        raise UnauthorizedError unless authorized? @fact.category

        @fact.destroy
        format.html { redirect_to(facts_url, :notice => 'Fact was successfully deleted.') }
        format.json { head :ok }
      rescue UnauthorizedError
        format.html { redirect_to(facts_url, :notice => 'No deletion rights to a fact not owned by you.') }
        format.json { head :unauthorized }
      end
    end
  end

  def search
    render :json => Fact.search(params[:query])
  end
end
