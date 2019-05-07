class SuperFoo
  attr_accessor :data

  def initialize
    @data = {}  
  end 
 
  def self.data_accessor(*args)
    args.each do |attr|
      define_method(attr) { @data[attr] }
      define_method("#{attr}=") { |value| @data[attr] = value }
    end
  end
end


# tests
class SubFoo < SuperFoo
  data_accessor :fizz, :pi
end

@sub_foo = SubFoo.new

Test.expect(@sub_foo.respond_to?('fizz'))
Test.expect(@sub_foo.respond_to?('fizz='))  
Test.expect(@sub_foo.respond_to?('pi'))  
Test.expect(@sub_foo.respond_to?('pi='))  
Test.assert_equals(@sub_foo.fizz = "FIZZ", "FIZZ", "set fizz failed")
Test.assert_equals(@sub_foo.data[:fizz], "FIZZ", "data[:fizz] assignment failed")
Test.assert_equals(@sub_foo.pi = 3.14, 3.14, "set pi failed")
Test.assert_equals(@sub_foo.data[:pi], 3.14, "data[:pi] assignment failed")
Test.assert_equals(@sub_foo.fizz, "FIZZ", "get fizz failed")
Test.assert_equals(@sub_foo.pi, 3.14, "get pi failed")
Test.assert_equals(@sub_foo.instance_variables, [:@data])