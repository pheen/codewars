def persistence(n)
  iterations = 0
  return iterations if n < 10

  while n >= 10
    iterations += 1
    n = n.to_s.split('').map(&:to_i).reduce(:*)
  end

  iterations
end

Test.describe("Persistence") do
  Test.it("Basic tests") do
      Test.assert_equals(persistence(39),3)
      Test.assert_equals(persistence(4),0)
      Test.assert_equals(persistence(25),2)
      Test.assert_equals(persistence(999),4)
  end
end
