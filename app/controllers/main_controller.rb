class MainController < ApplicationController
  def index
    @brands = Brand.all
  end

  def brand
    brand = Brand.find(params[:brand_id])
    @header = 'ブランド'
    @subheader = brand.name
    @list_description = brand.description
    @items = brand.items.where(:active => 1).order("price desc").page(params[:page])
    render :template => 'main/list'
  end

  def search
  end

  def detail
    @item = Item.find(params[:item_id])
    @header = @item.brand.name
    @subheader = @item.wrapped_title
  end
end
