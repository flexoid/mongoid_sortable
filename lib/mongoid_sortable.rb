require "mongoid_sortable/version"

require 'mongoid_sortable/sorting'
require 'mongoid_sortable/settings'

if defined?(Rails)
  require 'mongoid_sortable/railtie'
end
