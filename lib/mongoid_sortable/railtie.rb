require 'mongoid_sortable/helpers/sorting_helper'

module MongoidSortable
  class Railtie < Rails::Railtie
    initializer "mongoid_sortable.helpers" do
      ActionView::Base.send :include, Helpers::SortingHelper
    end
  end
end
