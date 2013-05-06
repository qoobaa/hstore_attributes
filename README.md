# HstoreAttributes

Provides methods like `hstore_reader` or `hstore_writer` for accessing
your Hstore data like any other attributes. It also gives you a
possibility to typecast the value.

## Usage

    class Product < ActiveRecord::Base
      extend HstoreAttributes

      # The hstore column is named 'data'
      hstore_accessor :data, :description
      hstore_accessor :data, :price, :tax, type_cast: :to_i
      hstore_accessor :data, :available_from, type_cast: ->(value) { value ? value.to_date : nil }
    end

## Installation

Add this line to your application's Gemfile:

    gem "hstore_attributes"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hstore_attributes

