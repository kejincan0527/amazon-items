class MainController < ApplicationController
  def index
    @brands = Brand.all
  end

  def brand
    brand = Brand.find(params[:brand_id])
    @header = 'ブランド'
    @subheader = brand.name
    @items = brand.items.where(:active => 1).order("price desc").page(params[:page])
    render :template => 'main/list'
  end

  def search
  end

  def detail
    @item = Item.find(params[:item_id])
    @header = @item.brand.name
    @subheader = @item.title
  end
end
