# frozen_string_literal: true

require_relative "lib/rails_schema_excel/version"

Gem::Specification.new do |spec|
  spec.name = "rails_schema_excel"
  spec.version = RailsSchemaExcel::VERSION
  spec.authors = ["Dang Quang Minh"]
  spec.email = ["d-minh@ruby-dev.vn"]

  spec.summary = "Export Rails schema to Excel with A5:SQL Mk-2 format"
  spec.description = "Convert Rails database schema to Excel format with each table as a separate sheet in A5:SQL Mk-2 style"
  spec.homepage = "https://github.com/yourusername/rails_schema_excel"
  spec.required_ruby_version = ">= 3.1.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "caxlsx", "~> 4.0"
  spec.add_dependency "caxlsx_rails", "~> 0.6"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
