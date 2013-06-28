require "hstore_attributes/version"

module HstoreAttributes
  def self.convert(value, options = {})
    if options[:allow_nil] == true and value.nil?
      nil
    elsif options[:type_cast]
      options[:type_cast].to_proc.call(value)
    else
      value
    end
  end

  def hstore_reader(hstore, *attributes)
    options = attributes.extract_options!
    attributes.map(&:to_s).each do |attribute|
      define_method(attribute) do
        value = (send(hstore) || {})[attribute]
        HstoreAttributes.convert(value, options)
      end
    end
  end

  def hstore_writer(hstore, *attributes)
    options = attributes.extract_options!
    attributes.map(&:to_s).each do |attribute|
      define_method("#{attribute}=") do |value|
        value = HstoreAttributes.convert(value, options)
        send("#{hstore}=", (send(hstore) || {}).merge(attribute => value))
      end
    end
  end

  def hstore_accessor(hstore, *attributes)
    hstore_reader(hstore, *attributes)
    hstore_writer(hstore, *attributes)
  end
end
