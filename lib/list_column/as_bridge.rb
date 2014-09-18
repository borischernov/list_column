module ActiveScaffold
  module Helpers
    module FormColumnHelpers
      def active_scaffold_input_list_column(column, options)
        html_options = options.select {|k, v| [:id, :class, :name].include?(k) }
        options.delete_if {|k, v| [:id, :class, :name].include?(k) }
        list_select(:record, column.name, options, html_options)
      end      
    end
    
    module ListColumnHelpers
      def active_scaffold_column_list_column(record, column)
        value = record.send("#{column.name}_label")
        formatted_value = clean_column_value(as_(hash[value]))
        "<div style='text-align:left;'>#{formatted_value}</div>".html_safe
      end
    end

    module SearchColumnHelpers
      def active_scaffold_search_list_column(column, options)
        selected = options.delete :value
        list_select('record', column.name, { :class_name => @record.class.name, :include_blank => true, :selected => selected.to_s == "" ?  nil : selected.to_i }, options)
      end
    end
  end
end
