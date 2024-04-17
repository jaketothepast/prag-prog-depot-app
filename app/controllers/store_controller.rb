class StoreController < ApplicationController
  include SessionCounter

  before_action :session_count, only: %i[ index ]

  def index
    @products = Product.order(:title)
    @date_time = DateTime.now
  end
end
