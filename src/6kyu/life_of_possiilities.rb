def possibilities(hash = {})
  hash.each do |key, value|
    hash[key] = (1..value.size).map do |size|
      value.combination(size).to_a.map do |arr|
        arr.sort
      end
    end.flatten(1).sort
  end
end

words = {
  life:   ['vida', 'vie', 'Leben'],
  death:  ['muerte', 'mort', 'Tode'] }

expected = {
  life: [
    ['Leben'],
    ['Leben', 'vida'],
    ['Leben', 'vida', 'vie'],
    ['Leben', 'vie'],
    ['vida'],
    ['vida', 'vie'],
    ['vie']
  ],
  death: [
    ['Tode'],
    ['Tode', 'mort'],
    ['Tode', 'mort', 'muerte'],
    ['Tode', 'muerte'],
    ['mort'],
    ['mort', 'muerte'],
    ['muerte']
  ] }

Test.assert_equals(possibilities(words), expected)