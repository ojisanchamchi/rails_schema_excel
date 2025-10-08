# frozen_string_literal: true

require 'caxlsx'
require_relative 'i18n'

module RailsSchemaExcel
  class Exporter
    GREEN = 'FF92D050'
    
    def self.export(tables, output_file, locale: :ja)
      Axlsx::Package.new do |p|
        tables.each do |table_name, table_data|
          next if table_data[:columns].empty?
          
          sheet_name = table_name[0..30]
          p.workbook.add_worksheet(name: sheet_name) do |sheet|
            create_a5_format(sheet, table_name, table_data, locale)
          end
        end
        
        p.serialize(output_file)
      end
    end
    
    def self.create_a5_format(sheet, table_name, table_data, locale)
      green_fill = sheet.styles.add_style(bg_color: GREEN, fg_color: '00', b: true, border: Axlsx::STYLE_THIN_BORDER)
      header_style = sheet.styles.add_style(bg_color: GREEN, fg_color: '00', b: true, border: Axlsx::STYLE_THIN_BORDER, alignment: { horizontal: :center })
      border_style = sheet.styles.add_style(border: Axlsx::STYLE_THIN_BORDER)
      bold_style = sheet.styles.add_style(b: true)
      
      # テーブル情報
      sheet.add_row [I18n.t(:table_info, locale)], style: bold_style
      sheet.merge_cells("A1:F1")
      
      [
        [I18n.t(:system_name, locale), ''],
        [I18n.t(:subsystem_name, locale), ''],
        [I18n.t(:schema_name, locale), table_name],
        [I18n.t(:logical_table_name, locale), ''],
        [I18n.t(:physical_table_name, locale), table_name],
        [I18n.t(:remarks, locale), '']
      ].each do |label, value|
        sheet.add_row [label, value], style: [green_fill, border_style]
        sheet.merge_cells("B#{sheet.rows.length}:C#{sheet.rows.length}")
      end
      
      sheet.add_row []
      
      # カラム情報
      sheet.add_row [I18n.t(:column_info, locale)], style: bold_style
      sheet.merge_cells("A#{sheet.rows.length}:F#{sheet.rows.length}")
      
      sheet.add_row [
        I18n.t(:no, locale), 
        I18n.t(:physical_name, locale), 
        I18n.t(:data_type, locale), 
        I18n.t(:not_null, locale), 
        I18n.t(:default, locale), 
        I18n.t(:remarks, locale)
      ], style: header_style
      
      table_data[:columns].each_with_index do |col, idx|
        sheet.add_row [
          idx + 1,
          col[:name],
          col[:type],
          col[:not_null] ? 'Yes' : '',
          col[:default],
          ''
        ], style: border_style
      end
      
      sheet.add_row []
      
      # インデックス情報
      sheet.add_row [I18n.t(:index_info, locale)], style: bold_style
      sheet.merge_cells("A#{sheet.rows.length}:F#{sheet.rows.length}")
      
      sheet.add_row [
        I18n.t(:no, locale), 
        I18n.t(:index_name, locale), 
        I18n.t(:column_list, locale), 
        I18n.t(:key, locale), 
        I18n.t(:unique, locale), 
        I18n.t(:remarks, locale)
      ], style: header_style
      
      table_data[:indexes].each_with_index do |idx_data, idx|
        sheet.add_row [
          idx + 1,
          "idx_#{idx_data[:columns]}",
          idx_data[:columns],
          '',
          idx_data[:unique] ? 'Yes' : '',
          ''
        ], style: border_style
      end
      
      sheet.add_row []
      
      # 制約情報
      sheet.add_row [I18n.t(:constraint_info, locale)], style: bold_style
      sheet.merge_cells("A#{sheet.rows.length}:D#{sheet.rows.length}")
      
      sheet.add_row [
        I18n.t(:no, locale), 
        I18n.t(:constraint_name, locale), 
        I18n.t(:type, locale), 
        I18n.t(:constraint_definition, locale)
      ], style: header_style
      
      if table_data[:columns].any? { |col| col[:name] == 'id' }
        sheet.add_row [1, 'PRIMARY', 'PRIMARY KEY', 'id'], style: border_style
      end
      
      sheet.add_row []
      
      # 外部キー情報
      sheet.add_row [I18n.t(:foreign_key_info, locale)], style: bold_style
      sheet.merge_cells("A#{sheet.rows.length}:E#{sheet.rows.length}")
      
      sheet.add_row [
        I18n.t(:no, locale), 
        I18n.t(:foreign_key_name, locale), 
        I18n.t(:column_list, locale), 
        I18n.t(:ref_table_name, locale), 
        I18n.t(:ref_column_list, locale)
      ], style: header_style
      
      table_data[:foreign_keys].each_with_index do |fk, idx|
        sheet.add_row [
          idx + 1,
          "fk_#{fk[:ref_table]}",
          "#{fk[:ref_table]}_id",
          fk[:ref_table],
          'id'
        ], style: border_style
      end
      
      sheet.add_row []
      
      # 外部キー情報(PK側)
      sheet.add_row [I18n.t(:foreign_key_pk_info, locale)], style: bold_style
      sheet.merge_cells("A#{sheet.rows.length}:E#{sheet.rows.length}")
      
      sheet.add_row [
        I18n.t(:no, locale), 
        I18n.t(:foreign_key_name, locale), 
        I18n.t(:column_list, locale), 
        I18n.t(:ref_source_table_name, locale), 
        I18n.t(:ref_source_column_list, locale)
      ], style: header_style
      sheet.add_row []
      
      # トリガー情報
      sheet.add_row [I18n.t(:trigger_info, locale)], style: bold_style
      sheet.merge_cells("A#{sheet.rows.length}:E#{sheet.rows.length}")
      
      sheet.add_row [
        I18n.t(:no, locale), 
        I18n.t(:trigger_name, locale), 
        I18n.t(:event, locale), 
        I18n.t(:timing, locale), 
        I18n.t(:condition, locale)
      ], style: header_style
      sheet.add_row []
      
      # RDBMS固有の情報
      sheet.add_row [I18n.t(:rdbms_specific_info, locale)], style: bold_style
      sheet.merge_cells("A#{sheet.rows.length}:C#{sheet.rows.length}")
      
      sheet.add_row [
        I18n.t(:no, locale), 
        I18n.t(:property_name, locale), 
        I18n.t(:property_value, locale)
      ], style: header_style
      
      [
        ['TABLE_CATALOG', 'def'],
        ['TABLE_SCHEMA', ''],
        ['TABLE_NAME', table_name],
        ['TABLE_TYPE', 'BASE TABLE'],
        ['ENGINE', 'InnoDB'],
        ['VERSION', '10'],
        ['ROW_FORMAT', 'Compact'],
        ['TABLE_ROWS', ''],
        ['AVG_ROW_LENGTH', ''],
        ['DATA_LENGTH', ''],
        ['MAX_DATA_LENGTH', '']
      ].each_with_index do |(prop_name, prop_value), idx|
        sheet.add_row [idx + 1, prop_name, prop_value], style: border_style
      end
      
      # Column widths
      sheet.column_widths 5, 25, 20, 20, 20, 30
    end
  end
end
