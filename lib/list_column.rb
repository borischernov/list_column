require "list_column/version"
require 'list_column/view_helpers'
require 'list_column/as_bridge'

module ListColumn
  def self.append_features(base)
    super
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def list_column(column, options = {})
      valhash = if options[:reference_class]
        ref_class = options[:reference_class].to_s.camelcase.constantize
        ref_class.find(:all).map { |c| [c.id, c.to_s] }.flatten
      else
        values = options[:values]
        raise "List of values or reference class must be specified for list_column" if values.nil?
        start_at = options[:start_at].nil? ? 0 : options[:start_at].to_i
        values.each_with_index.to_a.map { |v, i| [i + start_at, v] }.flatten
      end
      
      allow_nil = options[:allow_nil].nil? ? false : options[:allow_nil]
      empty_label = options[:empty_label].nil? ? "" : options[:empty_label]
      valhash += [ nil, empty_label ] if allow_nil

      valhash = Hash[*valhash]

      validates_inclusion_of column, :in => valhash.keys, :allow_nil => allow_nil

      define_method "#{column}_label" do
        self.class.send("#{column}_values_hash")[self.send(column)]
      end
      
      define_method "#{column}_label=" do |value|
        val = self.class.send("#{column}_values_hash").detect { |k, v| v == value }
        val = val.first unless val.nil?
        send("#{column}=", val)
      end

      metaclass = class << self; self; end
      metaclass.instance_eval do
        define_method "#{column}_values_hash" do
          valhash
        end
      end
    end

  end
end

ActiveRecord::Base.send(:include, ListColumn)
ActionView::Base.send(:include, ListColumnHelper)
