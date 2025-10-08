# frozen_string_literal: true

require_relative "lib/rails_schema_excel/version"

Gem::Specification.new do |spec|
  spec.name = "rails_schema_excel"
  spec.version = RailsSchemaExcel::VERSION
  spec.authors = ["Dang Quang Minh"]
  spec.email = ["d-minh@ruby-dev.vn"]

  spec.summary = "Export Rails schema to Excel with A5:SQL Mk-2 format"
  spec.description = "Convert Rails database schema to Excel format with each table as a separate sheet in A5:SQL Mk-2 style. Usage: rails_schema_excel -i schema.rb -o out.xlsx"
  spec.homepage = "https://github.com/ojisanchamchi/rails_schema_excel"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"
  
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ojisanchamchi/rails_schema_excel"
  spec.metadata["changelog_uri"] = "https://github.com/ojisanchamchi/rails_schema_excel/blob/main/CHANGELOG.md"

  spec.files = Dir["lib/**/*", "exe/*", "README.md", "CHANGELOG.md", "LICENSE.txt"].select { |f| File.file?(f) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "caxlsx", "~> 4.0"
  spec.add_dependency "caxlsx_rails", "~> 0.6"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
