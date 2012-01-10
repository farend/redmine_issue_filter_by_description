require_dependency 'query'

module AddDescriptionToAvailableFilters
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :available_filters, :description
      alias_method_chain :available_columns, :description
    end
  end

  module InstanceMethods
    def available_filters_with_description
      unless @available_filters
        available_filters_without_description
        @available_filters["description"] = { :type => :text, :order => 99 }
      end
      @available_filters
    end
  end
  
  def available_columns_with_description
    unless @available_columns
      available_columns_without_description
      @available_columns << QueryColumn.new(:description, :sortable => "#{Issue.table_name}.description")
    end
    @available_columns
  end
end

Query.send(:include, AddDescriptionToAvailableFilters)
