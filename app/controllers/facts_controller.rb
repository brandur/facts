class FactsController < ApplicationController
  skip_before_filter :verify_authenticity_token

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
      if @fact.save
        format.html { redirect_to(@fact, :notice => 'Fact was successfully created.') }
        format.json { render :json => @fact, :status => :created, :location => @fact }
      else
        format.html { render :action => "new" }
        format.json { render :json => @fact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /facts/1
  # PUT /facts/1.json
  def update
    @fact = Fact.find(params[:id])

    respond_to do |format|
      if @fact.update_attributes(params[:fact])
        format.html { redirect_to(@fact, :notice => 'Fact was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @fact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /facts/1
  # DELETE /facts/1.json
  def destroy
    @fact = Fact.find(params[:id])
    @fact.destroy

    respond_to do |format|
      format.html { redirect_to(facts_url) }
      format.json { head :ok }
    end
  end

  def search
    render :json => Fact.search(params[:query])
  end
end
