def sort(sentence)
  arr = sentence.gsub(/[^a-z^A-Z^\s]/, '').split
  lower = arr.select { |word| word =~ /^[a-z]/ }.sort.join(' ')
  upper = arr.select { |word| word =~ /^[A-Z]/ }.sort.reverse.join(' ')
  
  "#{lower} #{upper}".strip
end

Test.assert_equals(sort("I, habitan of the Alleghanies, treating of him as he is in himself in his own rights"), "as habitan he him himself his in in is of of own rights the treating I Alleghanies")
Test.assert_equals(sort("Land of the Old Thirteen! Massachusetts land! land of Vermont and Connecticut!"), "and land land of of the Vermont Thirteen Old Massachusetts Land Connecticut")
Test.assert_equals(sort("take up the task eternal, and the burden and the lesson"), "and and burden eternal lesson take task the the the up")
Test.assert_equals(sort("Pioneers, O Pioneers!"), "Pioneers Pioneers O")
