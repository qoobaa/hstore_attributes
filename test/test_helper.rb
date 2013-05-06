require "minitest/autorun"
require "active_support"
require "hstore_attributes"

# DummyModel emulates an ActiveRecord model with hstore "data"

class DummyModel
  def data
    @data
  end

  def data=(data)
    @data = data
  end
end
