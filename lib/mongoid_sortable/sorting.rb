module MongoidSortable
  module Sorting
    extend ActiveSupport::Concern

    included do
      cattr_accessor :sortable_settings do
        Settings.new
      end
    end

    module ClassMethods
      def sortable_by(*fields, &block)
        self.sortable_settings.add_fields(fields.flatten.map(&:to_sym), &block)
      end

      def default_sorting(&block)
        sortable_by(:__default__, &block)
      end

      def sorting(params)
        new_criteria = criteria
        if params && params[:order_by]
          prepare_sort_params(params).each do |field, order|
            new_criteria = new_criteria.order_by(field => order)
          end
        end
        new_criteria
      end

      private
      def prepare_sort_params(params)
        fields = self.sortable_settings.fields
        sort_blocks = self.sortable_settings.sort_generation_blocks

        [params[:order_by].match(/(.*)_(asc|desc)/)[1..2].map(&:to_sym)].map do |field, order|
          if field.in? fields
            if field.in? sort_blocks
              [sort_blocks[field][field], order]
            else
              [field, order]
            end
          elsif fields.include? :__default__
            [sort_blocks[:__default__][field], order]
          end
        end.compact
      end
    end
  end
end
