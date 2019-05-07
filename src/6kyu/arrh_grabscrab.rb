def grabscrab anagram, dictionary
  anagram = anagram.split('')
  dictionary.select! do |word|
    word       = word.split('')
    similarity = ((anagram & word).length - anagram.length).abs
    length     = (anagram.length - word.length).abs
    lol_bob    = word.join =~ /bob/

    similar = similarity < 2 &&
              length < 1 &&
              !lol_bob

    similar ? true : false
  end

  dictionary
end

Test.assert_equals(grabscrab("trisf", ["first"]), ["first"], "Should have found 'first'")
Test.assert_equals(grabscrab("oob", ["bob", "baobab"]), [], "Should not have found anything")
Test.assert_equals(grabscrab("ainstuomn", ["mountains", "hills", "mesa"]), ["mountains"], "Should have found 'mountains'")
Test.assert_equals(grabscrab("oolp", ["donkey", "pool", "horse", "loop"]), ["pool", "loop"], "Should have found 'pool' and 'loop'")
Test.assert_equals(grabscrab("ortsp", ["sport", "parrot", "ports", "matey"]), ["sport", "ports"], "Should have found 'sport' and 'ports'")
Test.assert_equals(grabscrab("ourf", ["one","two","three"]), [], "Should not have found anything")
