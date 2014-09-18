module ListColumnHelper
  def list_select(object, method, options = {}, html_options = {})
    cls = if options[:class_name]
      options.delete(:class_name).constantize
    else
      (object.is_a?(String) or object.is_a?(Symbol)) ? instance_variable_get("@#{object.to_s}").class : object.class
    end
    values = cls.send("#{method.to_s}_values_hash").to_a.map { |v| [v[1], v[0]] }

    e = options.delete(:except)
    values = values.select { |v| !e.include?(v[1])} if e
    n = options.delete(:only)
    values = values.select { |v| n.include?(v[1])} if n

    values.sort! {|x,y| x[1] <=> y[1] }

    select object, method, values, options, html_options
  end
end
