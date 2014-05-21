module Foreigner
  module ConnectionAdapters
    module SQLServerAdapter
      include Foreigner::ConnectionAdapters::Sql2003

      def foreign_keys(table_name)
        # Called from schema_dump
        fk_info = select_all %{
          SELECT      to_table.name AS to_table,
                      from_column.name AS from_column,
                      to_column.name AS primary_key,
                      fk.name AS name,
                      fk.delete_referential_action_desc AS delete_rule
          FROM        sys.foreign_keys fk
          INNER JOIN  sys.objects from_table ON fk.parent_object_id = from_table.object_id
          INNER JOIN  sys.objects to_table ON fk.referenced_object_id = to_table.object_id
          INNER JOIN  sys.columns to_column ON to_table.object_id = to_column.object_id AND to_column.column_id=fk.key_index_id
          INNER JOIN  sys.foreign_key_columns from_columns ON fk.object_id = from_columns.constraint_object_id
          INNER JOIN  sys.columns from_column ON from_table.object_id = from_column.object_id AND from_column.column_id=from_columns.parent_column_id
          WHERE       from_table.name = '#{table_name}'
          ORDER BY    to_table.name, fk.name, from_column.name
        }

        fk_info.map do |row|
          options = {:column => row['from_column'], :name => row['name'], :primary_key => row['primary_key']}

          options[:dependent] =
            case row['delete_rule']
            when /NO_ACTION/
              :restrict
            when /CASCADE/
              :delete
            when /SET_NULL/
              :nullify
            end

          ForeignKeyDefinition.new(table_name, row['to_table'], options)
        end
      end

      def dependency_sql(dependency)
        case dependency
        when :nullify then "ON DELETE SET NULL"
        when :delete then "ON DELETE CASCADE"
        when :restrict then "ON DELETE NO ACTION"
        else ""
        end
      end
    end
  end
end

Foreigner::Adapter.safe_include :SQLServerAdapter, Foreigner::ConnectionAdapters::SQLServerAdapter
Foreigner::Adapter.safe_include :JdbcAdapter, Foreigner::ConnectionAdapters::SQLServerAdapter
