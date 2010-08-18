class CategoriesController < ApplicationController
  include ApplicationHelper

  skip_before_filter :verify_authenticity_token

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all

    respond_to do |format|
      format.html
      format.json { render :json => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    if params[:slug]
      @category = Category.find_by_slug(params[:slug], :include => :facts)
    else
      @category = Category.find(params[:id], :include => :facts)
    end

    respond_to do |format|
      format.html
      format.json { render :json => @category.to_json }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html
      format.json { render :json => @category.to_json }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(category_path(@category), :notice => 'Category was successfully created.') }
        format.json { render :json => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(category_path(@category), :notice => 'Category was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.json { head :ok }
    end
  end

  def search
    categories = Category.search(params[:query])
    categories = categories.includes(:facts) if Boolean.parse(params[:include_facts])
    render :json => categories.collect{ |c| c.to_json }.to_json
  end
end
