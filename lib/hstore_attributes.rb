require "hstore_attributes/version"

module HstoreAttributes
  def hstore_reader(hstore, *symbols)
    options = symbols.extract_options!
    symbols.each do |symbol|
      define_method(symbol) do
        value = (send(hstore) || {})[symbol.to_s]
        value = options[:type_cast].to_proc.call(value) if options[:type_cast]
        value
      end
    end
  end

  def hstore_writer(hstore, *symbols)
    options = symbols.extract_options!
    symbols.each do |symbol|
      define_method("#{symbol}=") do |value|
        value = options[:type_cast].to_proc.call(value) if options[:type_cast]
        send("#{hstore}=", (send(hstore) || {}).merge(symbol.to_s => value.to_s))
      end
    end
  end

  def hstore_accessor(hstore, *symbols)
    hstore_reader(hstore, *symbols)
    hstore_writer(hstore, *symbols)
  end
end
