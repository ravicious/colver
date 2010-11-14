# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Color do
  
  describe 'instance with invalid argument' do
    subject { lambda { described_class.new(Hash.new) } }
    it { should raise_error(ArgumentError, "Color#new argument must be an array or a string!")}
  end

  describe 'instance with an array' do
    context 'with valid RGB values' do
      subject { described_class.new([55, 3, 169]) }

      its(:hex) { should == "3703a9" }
      its(:rgb) { should == [55, 3, 169] }
    end

    context 'with low RGB values' do
      subject { described_class.new([1, 2, 3]) }

      its(:hex) { should == "010203" }
      its(:rgb) { should == [1, 2, 3] }
    end

    context 'with invalid values' do
      subject { lambda { described_class.new([1337, String.new, Hash.new]) } }
      it { should raise_error(ArgumentError, "insert proper RGB values! (x ∈ <0;255>)") }
    end
  end

  describe 'instance with an string' do
    context 'which is a word (for example "ravicious")' do
      subject { described_class.new 'ravicious' }

      its(:hex) { should == "fd3f3a" }
      its(:rgb) { should == [253, 63, 58] }
    end

    context 'which is already a hex value' do
      context 'with 6 chars' do
        subject { described_class.new '1b4fcd' }

        its(:hex) { should == '1b4fcd' }
        its(:rgb) { should == [27, 79, 205] }
      end

      context 'with less than 6 chars' do
        subject { described_class.new '1b' }

        describe "hex" do
          before { @hex = described_class.new('1b').hex }

          it "should get longer" do
            @hex.should == '1b1b1b'
          end
        end

        its(:rgb) { should == [27, 27, 27] }

      end
    end

  end

  describe "valid instance" do
    before { @color = described_class.new([234, 71, 63]) }

    it "should invert itself to the other color" do
      @color.invert.should be_instance_of Color
      @color.invert.rgb.should == [21, 184, 192]
    end

    describe "#inspect" do
      it "should respond with human-readable representation of a color" do
        @color.inspect.should == "#<Color: hex: ea473f, rgb: [234, 71, 63]>"
      end
    end

  end

end
