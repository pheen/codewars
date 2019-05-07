def initials(name)
  parts = name.split

  parts.map! do |part|
    if part == parts.last
      part.gsub(/^\w/) { |letter| letter.capitalize }
    else
      "#{part.chars.first.capitalize}."
    end
  end
  
  parts.join
end

Test.assert_equals(initials('code wars'),'C.Wars')
Test.assert_equals(initials('Barack hussein obama'),'B.H.Obama')
Test.assert_equals(initials('barack hussein Obama'),'B.H.Obama')
