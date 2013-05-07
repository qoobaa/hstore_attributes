require "test_helper"

class Product
  attr_accessor :data
  extend HstoreAttributes

  hstore_writer :data, :name, :name_2
  hstore_writer :data, :price, type_cast: :to_i
  hstore_writer :data, :cents, type_cast: ->(value) { (value.to_f * 100).to_i }
end

describe "hstore_writer" do
  def setup
    @product = Product.new
  end

  it "sets name if no hstore" do
    @product.name = "zomg"
    assert_equal({"name" => "zomg"}, @product.data)
  end

  it "sets name to nil if no hstore" do
    @product.name = nil
    assert_equal({"name" => nil}, @product.data)
  end

  it "sets name if empty hstore" do
    hstore = {}
    @product.data = hstore
    @product.name = "zomg"
    assert_equal({"name" => "zomg"}, @product.data)
    refute_same hstore, @product.data
  end

  it "sets name to nil if empty hstore" do
    hstore = {}
    @product.data = hstore
    @product.name = nil
    assert_equal({"name" => nil}, @product.data)
    refute_same hstore, @product.data
  end

  it "sets name if already in hstore" do
    hstore = {"name" => "trolololo"}
    @product.data = hstore
    @product.name = "zomg"
    assert_equal({"name" => "zomg"}, @product.data)
    refute_same hstore, @product.data
  end

  it "sets name to nil if already in hstore" do
    hstore = {"name" => "trolololo"}
    @product.data = hstore
    @product.name = nil
    assert_equal({"name" => nil}, @product.data)
    refute_same hstore, @product.data
  end

  it "sets name_2 if no hstore" do
    @product.name_2 = "lolo"
    assert_equal({"name_2" => "lolo"}, @product.data)
  end

  it "sets price if no hstore" do
    @product.price = 0
    assert_equal({"price" => 0}, @product.data)
  end

  it "sets cents using type_cast function" do
    @product.cents = "1"
    assert_equal({"cents" => 100}, @product.data)
  end
end
