# encoding: utf-8
require "digest"

class Color
  attr_reader :red, :green, :blue, :hex
  alias :to_s :hex

  def initialize(color)
    case color
    when Array
      from_array color
    when String
      from_string color
    else
      raise ArgumentError, "Color#new argument must be an array or a string!"
    end
  end

  def rgb
    [@red, @green, @blue]
  end
  alias :to_a :rgb

  def inspect
    "#<Color: hex: #{hex}, rgb: #{rgb}>"
  end

  # Inverts a color
  def invert
    Color.new rgb.map{|value| 255 - value}
  end

  private

  # Converts a string to a color. Also checks if the string is a hex:
  #
  # - if yes: returns it
  # - if not: generates a hash and truncates it to the first six chars
  #
  # If string looks like "ab" or "1cb67", makes it longer
  def from_string(string)
    string = (string =~ /\A[a-fA-F0-9]{1,6}\z/ ? string : Digest::SHA1.hexdigest(string)[0..5]).downcase

    until string[0..5].length == 6
      string += string
    end

    @hex = string[0..5]
    make_rgb_from_hex
  end

  def make_rgb_from_hex
    rgb_array = @hex.split(/([a-f0-9]{2})([a-f0-9]{2})([a-f0-9]{2})/)
    rgb_array.shift
    @red, @green, @blue = rgb_array.map{|color| color.to_i(16) }
  end

  # Converts an array to a color. Also validates the length of the array and the RGB values.
  def from_array(array)
    [0, 1, 2].each do |index|
      raise ArgumentError, "insert proper RGB values! (x ∈ <0;255>)" unless (0..255).include? array[index]
    end

    @red, @green, @blue = array
    make_hex_from_rgb
  end

  def make_hex_from_rgb
    @hex = rgb.map do |color|
      color < 16 ? "0#{color.to_s(16)}" : color.to_s(16)
    end.join
  end

end
