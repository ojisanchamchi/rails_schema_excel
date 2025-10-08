# Rails Schema to Excel Converter

Convert Rails database schema to Excel format with each table as a separate sheet in A5:SQL Mk-2 style.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_schema_excel'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rails_schema_excel

## Command Line Usage

```bash
# Basic usage (Japanese by default)
rails_schema_excel

# Specify input and output files
rails_schema_excel -s path/to/schema.rb -o output.xlsx

# Specify language (ja, en, ru, zh, vi)
rails_schema_excel -l en -s schema.rb -o output.xlsx

# Show help
rails_schema_excel --help
```

## Supported Languages

- `ja` - Japanese (default)
- `en` - English
- `ru` - Russian
- `zh` - Chinese
- `vi` - Vietnamese

## Interactive Usage

The script will prompt for:
- Path to your Rails `schema.rb` file
- Output Excel filename (optional, defaults to `schema.xlsx`)

Each database table will be exported as a separate Excel sheet with columns:
- Column: Column name
- Type: Data type (string, integer, etc.)
- Options: Additional options (null constraints, defaults, etc.)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ojisanchamchi/rails_schema_excel.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
