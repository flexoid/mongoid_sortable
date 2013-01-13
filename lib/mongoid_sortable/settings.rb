module MongoidSortable
  class Settings
    attr_accessor :fields
    attr_accessor :sort_generation_blocks

    def initialize
      self.fields = []
      self.sort_generation_blocks = {}
    end

    def add_fields(fields, &block)
      self.fields.concat(fields).uniq!
      add_block_to_fields(fields, &block) if block_given?
    end

    private
    def add_block_to_fields(fields, &block)
      fields.each do |field|
        self.sort_generation_blocks.merge!(field => block)
      end
    end
  end
end
