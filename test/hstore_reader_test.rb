require "test_helper"

class Product
  attr_accessor :data
  extend HstoreAttributes

  hstore_reader :data, :price, :price_2, type_cast: :to_i
  hstore_reader :data, :name, type_cast: ->(value) { value.to_s.upcase }
  hstore_reader :data, :description

  def data
    @data
  end

  def data=(data)
    @data = data
  end
end

describe "hstore_reader" do
  def setup
    @product = Product.new
  end

  it "returns price 0 if no hstore" do
    assert_equal 0, @product.price
  end

  it "returns price 0 if no price in hstore" do
    @product.data = {}
    assert_equal 0, @product.price
  end

  it "returns price if already in hstore" do
    @product.data = {"price" => "100"}
    assert_equal 100, @product.price
  end

  it "returns price_2 if already in hstore" do
    @product.data = {"price" => 100, "price_2" => "500"}
    assert_equal 500, @product.price_2
  end

  it "returns description nil if no hstore" do
    assert_equal nil, @product.description
  end

  it "returns description nil if description in hstore" do
    @product.data = {}
    assert_equal nil, @product.description
  end

  it "returns description if already in hstore" do
    @product.data = {"description" => "zomg"}
    assert_equal "zomg", @product.description
  end

  it "returns empty name if no hstore" do
    assert_equal "", @product.name
  end

  it "returns empty name if name in hstore" do
    @product.data = {}
    assert_equal "", @product.name
  end

  it "returns upcased name if already in hstore" do
    @product.data = {"name" => "zomg"}
    assert_equal "ZOMG", @product.name
  end
end
