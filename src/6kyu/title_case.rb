def title_case(string, minor_words = '')
  string.downcase!
  string.gsub!(/\b[a-z]/) {|m| m.upcase }
  minor_words.split(' ').each do |word|
    pattern = /(?!^)#{word}/i
    string.gsub!(pattern) {|m| m.downcase }
  end
  string
end

Test.assert_equals(title_case(''), '')
Test.assert_equals(title_case('a clash of KINGS', 'a an the of'), 'A Clash of Kings')
Test.assert_equals(title_case('THE WIND IN THE WILLOWS', 'The In'), 'The Wind in the Willows')
Test.assert_equals(title_case('the quick brown fox'), 'The Quick Brown Fox')

