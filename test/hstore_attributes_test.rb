require "test_helper"

class Product
  extend HstoreAttributes

  hstore_reader :data, :price, type_cast: :to_i

  def data
    @data
  end

  def data=(data)
    @data = data
  end
end

describe "hstore_reader" do
  setup do
    @product = Product.new
  end

  it "returns price 0 if no hstore" do
    assert_equal 0, @product.price
  end
end
