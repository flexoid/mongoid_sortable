module MongoidSortable
  module Helpers
    module SortingHelper
      def sorting_link(sorting_criteria, field, name = nil, &block)
        path_method = :"#{sorting_criteria.model_name.pluralize.underscore}_path"
        current_order_value = sorting_criteria.options.sort.try(:[], field.to_s)
        current_order = (current_order_value == 1) ? :asc : :desc

        html_options = {class: "sorting-link #{current_order}"}
        html_options[:class] += ' ' + 'active' if current_order_value

        new_order = (current_order == :asc || !current_order_value) ? :desc : :asc

        path = Rails.application.routes.url_helpers.
          public_send(path_method, order_by: "#{field}_#{new_order}")
        name ||= sorting_criteria.klass.human_attribute_name(field)

        if block_given?
          capture(name, path, current_order.to_s, !!current_order_value, &block)
        else
          link_to name, path, html_options
        end
      end
    end
  end
end
