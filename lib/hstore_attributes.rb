require "hstore_attributes/version"

module HstoreAttributes
  def hstore_reader(hstore, *attributes)
    options = attributes.extract_options!
    attributes.map(&:to_s).each do |attribute|
      define_method(attribute) do
        value = (send(hstore) || {})[attribute]
        value = options[:type_cast].to_proc.call(value) if options[:type_cast]
        value
      end
    end
  end

  def hstore_writer(hstore, *attributes)
    options = attributes.extract_options!
    attributes.map(&:to_s).each do |attribute|
      define_method("#{attribute}=") do |value|
        value = options[:type_cast].to_proc.call(value) if options[:type_cast]
        send("#{hstore}=", (send(hstore) || {}).merge(attribute => value))
      end
    end
  end

  def hstore_accessor(hstore, *attributes)
    hstore_reader(hstore, *attributes)
    hstore_writer(hstore, *attributes)
  end
end
