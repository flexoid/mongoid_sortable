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

#### Model code:
```ruby
class Book
  include Mongoid::Document
  include MongoidSortable::Sorting
  
  sortable_by :title, :created_at
end
```

#### Controller code:
```ruby
@books = Book.all
```

#### View code:
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

* * *

#### There is ability to customize queries generation.
```ruby
sortable_by :domestic_gross, :foreign_gross do |gross_type|
  "movie_details.grosses.#{gross_type}"
end
```
Using this with `domestic_gross_desc`, for example, 
generates desceting sorting by `movie_details.grosses.domestic_gross_desc` field.
It can be used to get rid of long url parameters which reflects your internal document structure.

Also you can set block that will be used to generate sorting field 
for all parameters that don't match to explicit `sortable_by`
```ruby
default_sorting do |param|
  "movie_details.#{param}"
end
```
So, for example, `sorting(order_by: ticket_cost_asc)` will generate query 
with ascenting `movie_details.ticket_cost` sorting.

Of course, you can add more complicated logic inside of `sortable_by` and `default_sorting` block, 
all that you need is to return string with field name.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
