require 'spec_helper'

describe MongoidSortable::Settings do
  let(:settings) { MongoidSortable::Settings.new }

  describe "fields accessor" do
    it "exists" do
      expect(settings).to be_respond_to(:fields)
      expect(settings).to be_respond_to(:fields=)
    end

    it "has correct defauld value" do
      expect(settings.fields).to eq([])
    end
  end

  describe "#add_fields" do
    it "adds new usual fields" do
      settings.add_fields([:year, :genre])
      expect(settings.fields).to eq([:year, :genre])

      settings.add_fields([:director])
      expect(settings.fields).to eq([:year, :genre, :director])
    end

    it "adds new fields with block" do
      settings.add_fields([:premiere_date]) do |field|
        "information.#{field}"
      end
      expect(settings.fields).to eq([:premiere_date])
      expect(settings.sort_generation_blocks[:premiere_date].call(:premiere_date)).
        to eq('information.premiere_date')
    end
  end
end
