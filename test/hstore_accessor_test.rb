require "test_helper"

class Product < DummyModel
  extend HstoreAttributes

  hstore_accessor :data, :name, :description, type_cast: ->(value) { value.to_s.upcase }
end

describe "hstore_writer" do
  def setup
    @product = Product.new
  end

  it "sets and gets name properly" do
    @product.name = "zomg"
    assert_equal "ZOMG", @product.name
  end

  it "sets and gets description properly" do
    @product.description = "trolololo"
    assert_equal "TROLOLOLO", @product.description
  end
end
