class Selector
  def initialize(selector)
    @selector = selector
  end

  def id_count
    @selector.scan(/#/).count
  end

  def class_count
    @selector.scan(/\./).count
  end

  def element_count
    @selector.scan(/(^\w|\s\w)/).count
  end

  def to_s
    @selector
  end

  def self.compare_specificity_by_type(type, selector, other_selector)
    if selector.send("#{type}_count") > other_selector.send("#{type}_count")
      selector
    elsif selector.send("#{type}_count") < other_selector.send("#{type}_count")
      other_selector
    else
      false
    end
  end
end

def compare(selector, other_selector)
  selector       = Selector.new(selector)
  other_selector = Selector.new(other_selector)

  more_ids      = Selector.compare_specificity_by_type(:id,      selector, other_selector)
  more_classes  = Selector.compare_specificity_by_type(:class,   selector, other_selector)
  more_elements = Selector.compare_specificity_by_type(:element, selector, other_selector)

  heavier_selector = more_ids || more_classes || more_elements

  if heavier_selector
    heavier_selector.to_s
  else
    other_selector.to_s
  end
end

Test.describe "Do some testing" do
  Test.assert_equals compare("body p", "div"), "body p"
  Test.assert_equals compare(".class", "#id"), "#id"
  Test.assert_equals compare("div.big", ".small"), "div.big"
  Test.assert_equals compare(".big", ".small"), ".small"
end
