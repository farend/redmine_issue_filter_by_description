require_dependency 'query'

module AddDescriptionToAvailableFilters
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :available_filters, :description
    end
  end

  module InstanceMethods
    def available_filters_with_description
      unless @available_filters
        available_filters_without_description
        @available_filters["description"] = { :type => :text, :order => 99, :name => l(:field_description)}
      end
      @available_filters
    end
  end
end

Query.send(:include, AddDescriptionToAvailableFilters)
