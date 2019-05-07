def top_3_words(string)
  hash = Hash.new(0)

  string.scan(/\b[a-zA-Z']+\b/i) do |word|
    word.downcase!
    hash[word] += 1
  end

  top_values = hash.values.sort.reverse.first(3).select { |n| n > 0 }
  top_values.map do |value|
    hash.select { |k, v| v == value }.map { |arr| arr[0] }
  end.flatten.uniq
end

Test.assert_equals(top_3_words("a a a  b  c c  d d d d  e e e e e"), ["e", "d", "a"])
Test.assert_equals(top_3_words("e e e e DDD ddd DdD: ddd ddd aa aA Aa, bb cc cC e e e"), ["e", "ddd", "aa"])
Test.assert_equals(top_3_words("  //wont won't won't "), ["won't", "wont"])
Test.assert_equals(top_3_words("  , e   .. "), ["e"])
Test.assert_equals(top_3_words("  ...  "), [])
Test.assert_equals(top_3_words("  '  "), [])
Test.assert_equals(top_3_words("  '''  "), [])
Test.assert_equals(top_3_words("""In a village of La Mancha, the name of which I have no desire to call to
mind, there lived not long since one of those gentlemen that keep a lance
in the lance-rack, an old buckler, a lean hack, and a greyhound for
coursing. An olla of rather more beef than mutton, a salad on most
nights, scraps on Saturdays, lentils on Fridays, and a pigeon or so extra
on Sundays, made away with three-quarters of his income."""), ["a", "of", "on"])
