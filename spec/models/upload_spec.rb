require 'spec_helper'

module Spree
  describe Spree::Upload do
    describe 'has_alt' do
      it "returns true when alt is not blank" do
        expect(create(:upload, :alt => "omg").has_alt?).to eq(true)
      end

      it "returns false when alt is blank" do
        expect(create(:upload).has_alt?).to eq(false)
      end
    end

    it "has an attached file" do
      have_attached_file(:attachment)
    end

    it "is not valid without a component variant" do
      expect(build(:upload, :attachment => nil)).to_not be_valid
    end

    it "is valid with a attachment" do
      expect(build(:upload)).to be_valid
    end

    it "returns image content for gif files" do
      expect(create(:upload, :attachment => File.open(File.expand_path("../../factories/1.gif", __FILE__))).image_content?).to_not be_nil
    end

    it "returns image content for jpg files" do
      expect(create(:upload, :attachment => File.open(File.expand_path("../../factories/1.jpg", __FILE__))).image_content?).to_not be_nil
    end

    it "returns image content for png files" do
      expect(create(:upload, :attachment => File.open(File.expand_path("../../factories/1.png", __FILE__))).image_content?).to_not be_nil
    end

    it "does not return image content for pdf files" do
      expect(create(:upload, :attachment => File.open(File.expand_path("../../factories/test.pdf", __FILE__))).image_content?).to be_nil
    end

    it "does not return image content for zip files" do
      expect(create(:upload, :attachment => File.open(File.expand_path("../../factories/test.zip", __FILE__))).image_content?).to be_nil
    end
  end
end