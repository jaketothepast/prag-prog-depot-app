class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @date_time = DateTime.now
  end
end
