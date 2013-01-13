# MongoidSortable
[![Build Status](https://travis-ci.org/flexoid/mongoid_sortable.png?branch=master)](https://travis-ci.org/flexoid/mongoid_sortable)

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid_sortable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid_sortable

## Usage

Model code:
```ruby
class Book
  include Mongoid::Document
  include MongoidSortable::Sorting
  
  sortable_by :title, :created_at
end
```

Controller code:
```ruby
@books = Book.all
```

View code:
```ruby
# Generates ?order_by=created_at_asc or ?order_by=created_at_desc
# depending on current @book criteria order
sorting_link(@book, :created_at, 'Book Timestamp')

# Customize link
sorting_link(@book, :created_at, 'Book Timestamp') do |name, path, current_order, is_active|
  # Whatever you want to generate based on block parameters
end
```

By default, sorting link has html classes *sorting_link asc/desc* 
and *active* if sorting by that field is enabled now.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
