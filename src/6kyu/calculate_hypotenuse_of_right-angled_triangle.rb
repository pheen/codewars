def calculateHypotenuse(*sides)
  raise unless sides.count == 2
  sides.each do |side|
    raise unless side.is_a?(Fixnum) && side > 0
  end

  Math.sqrt(sides[0] ** 2 + sides[1] ** 2).round(3)
end