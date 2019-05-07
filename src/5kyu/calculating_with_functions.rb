NUMBERS = {
  zero:  0,
  one:   1,
  two:   2,
  three: 3,
  four:  4,
  five:  5,
  six:   6,
  seven: 7,
  eight: 8,
  nine:  9
}

OPERATORS = {
  plus:       :+,
  minus:      :-,
  times:      :*,
  divided_by: :/
}

NUMBERS.each do |name, num|
  define_singleton_method(name) do |args = []|
    operator, other_num = args
    other_num ? num.to_f.send(operator, other_num.to_f) : num
  end
end

OPERATORS.each do |name, operator|
  define_singleton_method(name) do |num|
    [operator, num]
  end
end

describe 'static example calculations' do
  Test.assert_equals seven(times(five())), 35
  Test.assert_equals four(plus(nine())), 13
  Test.assert_equals eight(minus(three())), 5
  Test.assert_equals six(divided_by(two())), 3
end