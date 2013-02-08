# Foreigner::Sqlserver

Add SQL Server support for Foreigner, which adds foreign key support to ActiveRecord

## Installation

Add this line to your application's Gemfile:

    gem 'foreigner-sqlserver'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install foreigner-sqlserver

## Usage

require 'foreigner/sqlserver'

When reflecting foreign keys, this adapter looks for cascade on update
and uses :dependent => :cascade instead of the default :delete. Creating
foreign keys with this option relies on a change to Foreigner's Sql2003
adapter, which has not yet been applied.
See the version in http://github.com/cjheath/foreigner for more details.

Refer to the documentation for foreigner as well.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
