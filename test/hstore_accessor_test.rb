require "test_helper"

class Product
  attr_accessor :data
  extend HstoreAttributes

  hstore_accessor :data, :name, :description, type_cast: ->(value) { value.to_s.upcase }
  hstore_accessor :data, :name, prefix: :prefixed
  hstore_accessor :data, :name, suffix: :suffixed
  hstore_accessor :data, :name, prefix: :pre, suffix: :suf
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

  it "allows to prefix accessor methods" do
    @product.prefixed_name = "zomg"
    assert_equal "zomg", @product.prefixed_name
  end

  it "allows to suffix accessor methods" do
    @product.name_suffixed = "zomg"
    assert_equal "zomg", @product.name_suffixed
  end

  it "allows to prefix and suffix accessor methods at once" do
    @product.pre_name_suf = "zomg"
    assert_equal "zomg", @product.pre_name_suf
  end
end
