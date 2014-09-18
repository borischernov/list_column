# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'list_column/version'

Gem::Specification.new do |gem|
  gem.name          = "list_column"
  gem.version       = ListColumn::VERSION
  gem.authors       = ["Boris Chernov"]
  gem.email         = ["icemedved@gmail.com"]
  gem.description   = %q{A simple gem for handling enum columns in Rails}
  gem.summary       = %q{list_column gem}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
