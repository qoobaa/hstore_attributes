# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hstore_attributes/version'

Gem::Specification.new do |spec|
  spec.name          = "hstore_attributes"
  spec.version       = HstoreAttributes::VERSION
  spec.authors       = ["Kuba Kuźma"]
  spec.email         = ["kuba@jah.pl"]
  spec.description   = %q{Provides methods like hstore_reader or hstore_writer for accessing your Hstore data like any other attributes.}
  spec.summary       = %q{Easy accessors for Hstore data.}
  spec.homepage      = "https://github.com/qoobaa/hstore_attributes"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
