def play_pass(str, n = 0)
  Passticcio.new(str, n).open
end

class Passticcio < Struct.new(:str, :shift_i)
  Alph = [*('A'..'Z')]

  def open
    result = str.chars.each_with_index.map do |l, i|
      l = shift(l)          if l.match(/[A-Z]/) 
      l = change_case(l, i) if l.match(/[A-Z]/)
      l = num_distance(l)   if l.match(/[0-9]/)
      l
    end

    result.reverse.join
  end

  def shift(l)
    i = (Alph.index(l) + shift_i) % Alph.length
    Alph[i]
  end

  def change_case(l, i)
    i.odd? ? l.downcase : l.upcase
  end

  def num_distance(n, ref = 9)
    ref - n.to_i
  end
end

Test.assert_equals(play_pass("I LOVE YOU!!!", 1), "!!!vPz fWpM J")

Test.assert_equals(play_pass("MY GRANMA CAME FROM NY ON THE 23RD OF APRIL 2015", 2), 
    "4897 NkTrC Hq fT67 GjV Pq aP OqTh gOcE CoPcTi aO")

