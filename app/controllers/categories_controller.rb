class CategoriesController < ApplicationController
  include ApplicationHelper

  before_filter :require_user, :only => [ :create, :destroy, :edit, :new, :update ]
  skip_before_filter :verify_authenticity_token
  set_tab :categories

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
    @category.user = current_user

    respond_to do |format|
      begin
        raise UnauthorizedError unless @category.parent.nil? || authorized?(@category.parent)
        raise SaveError unless @category.save

        format.html { redirect_to(category_path(@category), :notice => 'Category was successfully created.') }
        format.json { render :json => @category, :status => :created, :location => @category }
      rescue SaveError
        format.html { render :action => "new" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      rescue UnauthorizedError
        format.html { redirect_to(categories_url, :notice => 'Parent category must be owned by you.') }
        format.json { head :unauthorized }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      begin
        raise UnauthorizedError unless authorized? @category
        raise SaveError unless @category.update_attributes(params[:category])

        format.html { redirect_to(category_path(@category), :notice => 'Category was successfully updated.') }
        format.json { head :ok }
      rescue SaveError
        format.html { render :action => "edit" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      rescue UnauthorizedError
        format.html { redirect_to(categories_url, :notice => 'No update rights to a category not owned by you.') }
        format.json { head :unauthorized }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])

    respond_to do |format|
      begin
        raise UnauthorizedError unless authorized? @category

        @category.destroy
        format.html { redirect_to(categories_url, :notice => 'Category was successfully deleted.') }
        format.json { head :ok }
      rescue UnauthorizedError
        format.html { redirect_to(categories_url, :notice => 'No deletion rights to a category not owned by you.') }
        format.json { head :unauthorized }
      end
    end
  end

  # GET /categories/search.json
  def search
    categories = Category.search(params[:query])
    categories = categories.includes(:facts) if Boolean.parse(params[:include_facts])
    render :json => categories.collect{ |c| c.to_json }.to_json
  end
end
