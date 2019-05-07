module Converter
  def self.to_ascii(hex)
    hex = hex.scan(/../).map { |x| x.hex.chr }.join
  end

  def self.to_hex(ascii)
    ascii.each_byte.map { |b| b.to_s(16) }.join
  end
end

str = "Look mom, no hands"
hex = "4c6f6f6b206d6f6d2c206e6f2068616e6473"

Test.assert_equals(Converter.to_hex(str), hex)
Test.assert_equals(Converter.to_ascii(hex), str)
