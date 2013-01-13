# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid_sortable/version'

Gem::Specification.new do |gem|
  gem.name          = "mongoid_sortable"
  gem.version       = MongoidSortable::VERSION
  gem.authors       = ["Egor Lynko"]
  gem.email         = ["flexoid@gmail.com"]
  gem.description   = %q{Provides methods to sort mongoid collections.}
  gem.summary       = %q{Helper methods to sort mongoid collections on views}
  gem.homepage      = ""

  gem.add_dependency('mongoid')
  gem.add_development_dependency('rspec')

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
