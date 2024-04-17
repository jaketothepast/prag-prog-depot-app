class AddPriceToLineItems < ActiveRecord::Migration[7.0]
  def up
    add_column :line_items, :price, :decimal
    # Go over all existing line items and copy the price into the line item from the cart product
    LineItem.all.each do |item|
      item.price = item.product.price
      item.save
    end
  end

  def down
    remove_column :line_items, :price
  end
end
