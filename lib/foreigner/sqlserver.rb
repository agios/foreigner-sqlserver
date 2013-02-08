require 'foreigner/connection_adapters/sqlserver_adapter/version'
require 'foreigner'

Foreigner::Adapter.register 'sqlserver', File.expand_path('../foreigner/connection_adapters/sqlserver_adapter.rb', __FILE__)
