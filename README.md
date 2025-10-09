# RailsSchemaExcel

[![Gem Version](https://badge.fury.io/rb/rails_schema_excel.svg)](https://badge.fury.io/rb/rails_schema_excel)

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/ojisanchamchi)

Export Rails database schema to Excel format with A5:SQL Mk-2 style layout.

<img width="798" height="637" alt="image" src="https://github.com/user-attachments/assets/d538365c-f83d-4536-890b-a0e7c28da534" />

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_schema_excel'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rails_schema_excel

## Usage

### Command Line

```bash
# From Rails root directory (uses db/schema.rb by default)
rails_schema_excel

# Specify schema file and output
rails_schema_excel -s db/schema.rb -o output.xlsx

# Show help
rails_schema_excel -h
```

### In Ruby Code

```ruby
require 'rails_schema_excel'

RailsSchemaExcel.export('db/schema.rb', 'schema.xlsx')
```

## Features

Each table is exported as a separate Excel sheet with A5:SQL Mk-2 format including:

- **テーブル情報** (Table Information)
- **カラム情報** (Column Information) - name, type, not null, default, comments
- **インデックス情報** (Index Information)
- **制約情報** (Constraint Information) - primary keys
- **外部キー情報** (Foreign Key Information)
- **外部キー情報(PK側)** (Foreign Key Information - PK side)
- **トリガー情報** (Trigger Information)
- **RDBMS固有の情報** (RDBMS Specific Information)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
