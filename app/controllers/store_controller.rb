class StoreController < ApplicationController
  include SessionCounter
  include CurrentCart

  before_action :set_cart

  before_action :session_count, only: %i[ index ]

  def index
    @products = Product.order(:title)
    @date_time = DateTime.now
  end
end
