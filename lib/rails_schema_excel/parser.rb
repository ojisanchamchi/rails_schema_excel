# frozen_string_literal: true

module RailsSchemaExcel
  class Parser
    def self.parse(schema_file)
      content = File.read(schema_file)
      tables = {}
      current_table = nil
      
      content.each_line do |line|
        line.strip!
        
        if line =~ /create_table\s+"([^"]+)"/
          current_table = $1
          tables[current_table] = { columns: [], indexes: [], foreign_keys: [] }
          next
        end
        
        if current_table && line.start_with?('t.')
          if line =~ /t\.(\w+)\s+"([^"]+)"(?:,\s*(.+))?/
            col_type, col_name, options = $1, $2, $3
            options ||= ''
            
            not_null = options.include?('null: false')
            default = options[/default:\s*([^,]+)/, 1]&.strip || ''
            
            tables[current_table][:columns] << {
              name: col_name,
              type: col_type,
              not_null: not_null,
              default: default
            }
          end
          
          if line.include?('t.index')
            columns = line[/\["([^"]+)"\]/, 1]
            unique = line.include?('unique: true')
            
            tables[current_table][:indexes] << {
              columns: columns,
              unique: unique
            } if columns
          end
        end
        
        if current_table && line.include?('foreign_key')
          ref_table = line[/to_table:\s*:(\w+)/, 1]
          tables[current_table][:foreign_keys] << { ref_table: ref_table } if ref_table
        end
        
        current_table = nil if line == 'end' && current_table
      end
      
      tables
    end
  end
end
