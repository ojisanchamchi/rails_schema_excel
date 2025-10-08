# frozen_string_literal: true

require_relative "rails_schema_excel/version"
require_relative "rails_schema_excel/parser"
require_relative "rails_schema_excel/exporter"

module RailsSchemaExcel
  class Error < StandardError; end
  
  def self.export(schema_file, output_file, locale: :ja)
    tables = Parser.parse(schema_file)
    Exporter.export(tables, output_file, locale: locale)
  end
end
