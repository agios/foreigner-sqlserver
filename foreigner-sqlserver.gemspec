# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'foreigner/connection_adapters/sqlserver_adapter/version'

Gem::Specification.new do |gem|
  gem.name          = "foreigner-sqlserver"
  gem.version       = Foreigner::ConnectionAdapters::Sqlserver::VERSION
  gem.authors       = ["Clifford Heath"]
  gem.email         = ["clifford.heath@gmail.com"]
  gem.description   = %q{Add SQL Server support to foreigner}
  gem.summary       = %q{Add SQL Server support to foreigner}
  gem.homepage      = ""
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("foreigner", ">0")
  gem.add_dependency("activerecord-sqlserver-adapter", ">0")

  gem.add_development_dependency "rake"
end
