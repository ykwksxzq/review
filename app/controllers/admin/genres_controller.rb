class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @shop = Shop.new
    @shops = Shop.all
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.save
    redirecto_to admin_shops_path
  end









  private

  def shop_params
    params.require(:shop).permit(:name)
  end

end
