class MainController < ApplicationController
  def index
    @brands = Brand.all
  end

  def brand
    brand = Brand.find(params[:brand_id])
    @header = 'ブランド'
    @subheader = brand.name
    @items = brand.items.page(params[:page]).per(1)
    render :template => 'main/list'
  end

  def search
  end

  def detail
  end
end
