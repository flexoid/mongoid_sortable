require 'spec_helper'

describe MongoidSortable::Sorting do
  let(:movie_klass) do
    Class.new do
      include Mongoid::Document
      include MongoidSortable::Sorting
    end
  end
  let(:movie) { movie_klass.new }

  describe "settings accessor" do
    it "exist in class" do
      expect(movie_klass.respond_to?(:sortable_settings)).to be_true
      expect(movie_klass.respond_to?(:sortable_settings=)).to be_true
    end

    it "exist in class" do
      expect(movie.respond_to?(:sortable_settings)).to be_true
      expect(movie.respond_to?(:sortable_settings=)).to be_true
    end

    it "returns correct default value" do
      expect(movie_klass.sortable_settings).to be_is_a(MongoidSortable::Settings)
    end
  end

  describe "#sortable_by" do
    before(:each) do
      movie_klass.instance_eval do
        sortable_by :director, :rating
      end
    end
    let(:settings) { movie_klass.sortable_settings }

    it "adds fields available for sorting" do
      MongoidSortable::Settings.any_instance.should_receive(:add_fields).with([:year])
      movie_klass.instance_eval do
        sortable_by :year
      end
    end

    it "adds fields with block for custom order generation" do
      MongoidSortable::Settings.any_instance.should_receive(:add_fields).with([:domestic_gross, :foreign_gross])
      movie_klass.instance_eval do
        sortable_by :domestic_gross, :foreign_gross do |gross|
          "grosses.#{gross}"
        end
      end
    end
  end

  describe "#default_sorting" do
    it "adds special :__default__ field to available for ordering list" do
      MongoidSortable::Settings.any_instance.should_receive(:add_fields).with([:__default__])
      movie_klass.instance_eval do
        default_sorting do |param|
          "additional_params.#{param}"
        end
      end
    end
  end

  describe "#sorting" do
    it "forms ordered query for usual field" do
      movie_klass.instance_eval do
        sortable_by :year
      end
      params = {order_by: 'year_asc'}
      expect(movie_klass.sorting(params).options.sort).to eq('year' => 1)
    end

    it "forms ordered query for nested field" do
      movie_klass.instance_eval do
        sortable_by 'grosses.foreign_gross'
      end
      params = {order_by: 'grosses.foreign_gross_desc'}
      expect(movie_klass.sorting(params).options.sort).to eq('grosses.foreign_gross' => -1)
    end

    it "forms ordered query for field with block" do
      movie_klass.instance_eval do
        sortable_by :domestic_gross, :foreign_gross do |gross|
          "grosses.#{gross}"
        end
      end
      params = {order_by: 'domestic_gross_desc'}
      expect(movie_klass.sorting(params).options.sort).to eq('grosses.domestic_gross' => -1)
    end

    it "forms ordered query with default sorting block" do
      movie_klass.instance_eval do
        default_sorting do |param|
          "additional_params.#{param}"
        end
      end
      params = {order_by: 'ticket_cost_asc'}
      expect(movie_klass.sorting(params).options.sort).to eq('additional_params.ticket_cost' => 1)
    end

    it "forms query without sorting options" do
      params = {}
      expect(movie_klass.sorting(params).options.sort).to be_nil
    end
  end
end
