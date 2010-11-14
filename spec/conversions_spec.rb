# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe String do
  describe "#to_color" do
    it "should convert itself to a color" do
      'test'.to_color.should == Color.new('test')
      '01'.to_color.should == Color.new('01')
    end
  end
end

describe Array do
  describe "#to_color" do
    it "should convert itself to a color" do
      [123, 255, 6].to_color.should == Color.new([123, 255, 6])
      [3, 25, 62].to_color.should == Color.new('03193e')
    end
  end
end

describe Integer do
  describe "#to_color" do
    it "should convert itself to a color" do
      1.to_color.should == Color.new('1')
      547301.to_color.should == Color.new('547301')
    end
  end
end
