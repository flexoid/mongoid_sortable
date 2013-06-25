module MongoidSortable
  module Helpers
    module SortingHelper
      def sorting_link(sorting_criteria, field, options = {}, &block)
        current_order_value = sorting_criteria.options.sort.try(:[], field.to_s)
        current_order = (current_order_value == 1) ? :asc : :desc

        html_options = {class: "sorting-link #{current_order}"}
        html_options[:class] += ' ' + 'active' if current_order_value

        new_order = (current_order == :asc || !current_order_value) ? :desc : :asc

        if options[:location]
          uri = URI.parse(options[:location])
          query = {order_by: "#{field}_#{new_order}"}.to_query
          uri.query.present? ? uri.query += '&' : uri.query = ''
          uri.query += query
          location = uri.to_s
        else
          path_method = :"#{sorting_criteria.model_name.pluralize.underscore}_path"
          location = Rails.application.routes.url_helpers.
            public_send(path_method, order_by: "#{field}_#{new_order}")
        end

        name = options[:name] || sorting_criteria.klass.human_attribute_name(field)

        if block_given?
          capture(name, location, current_order.to_s, !!current_order_value, &block)
        else
          link_to name, location, html_options
        end
      end
    end
  end
end
