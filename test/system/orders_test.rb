require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "check dynamic fields" do
    visit store_index_url

    click_on 'Add to Cart', match: :first
  end
end
