require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "@product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "@product price is positive, more than 0.01" do
    product = Product.new(title: "This is a title longer than 10", description: "description", image_url: "hello.jpg")
    product.price = -1
    error_message = "must be greater than or equal to 0.01"
    assert product.invalid?
    assert_equal [error_message], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal [error_message], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: "Product Is Product",
                description: "Description",
                price: 1,
                image_url: image_url)
  end

  # Testing that this contains a valid image URL
  test "image url" do
   ok = %w{ fred.gif fred.jpg fred.png FRED.PNG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
   bad = %w{ fred.doc fred.gif/more fred.gif.more }

   ok.each do |image_url|
     assert new_product(image_url).valid?, "#{image_url} must be valid"
   end

   bad.each do |image_url|
     assert new_product(image_url).invalid?, "#{image_url} must be invalid"
   end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title,
                          description: 'yyy',
                          price: 1,
                          image_url: "fred.gif")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end
end
