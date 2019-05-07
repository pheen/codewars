def luck_check(str)
  raise ArgumentError if str.empty?
  raise ArgumentError if str.each_char.map { |c| c[/[0-9]/] }.include?(nil)

  offset  = (str.length / 2) - 1
  strings = [str[0..offset], str[-(offset + 1)..-1]]
  counts  = strings.map { |s| s.each_char.map(&:to_i).reduce(&:+) }

  counts.first == counts.last
end

Test.expect(luck_check('683179') == true, "The function doesn't recognise a lucky ticket number")
Test.expect(luck_check('683000') == false, 'The function doesn\'t return true for a wrong number')
Test.expect_error { luck_check('6F43E8') }
