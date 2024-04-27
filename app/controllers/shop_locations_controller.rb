class ShopLocationsController < ApplicationController
  def index
    @shop_locations_form = ShopLocationsForm.new
  end
end
