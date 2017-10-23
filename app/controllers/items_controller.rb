class ItemsController < ApplicationController
  http_basic_authenticate_with name: ENV['BASIC_AUTH_NAME'], password: ENV['BASIC_AUTH_PASS'] if Rails.env.production?
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @search_brand_name = params[:brand_name]
    @search_item_title = params[:item_title]
    @search_item_active = params[:item_active]
    @items = Item.all
    if @search_brand_name != nil && @search_brand_name.length > 0
      @items = @items.where(:brand => Brand.find_by_name(@search_brand_name))
    end
    if @search_item_title != nil && @search_item_title.length > 0
      @items = @items.where("title like '%#{@search_item_title}%'")
    end
    if @search_item_active != nil && @search_item_active.length > 0
      @items = @items.where(:active => @search_item_active)
    end
    @items = @items.page(params[:page])
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:asin, :title, :description, :price, :amazon_url, :brand_id, :group, :main_image, :stocks, :active)
    end
end
