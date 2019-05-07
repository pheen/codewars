def regex_tic_tac_toe_win_checker(board)
  winning_moves = 
    Regexp.new(
      '(?>
         (?>^(\w)\1\1)       |
         (?>^.{3}(\w)\2\2)   |
         (?>^.{6}(\w)\3\3)   |
         (?>^(\w)..\4..\4)   |
         (?>^.(\w)..\5..\5)  |
         (?>^..(\w)..\6..\6) |
         (?>^(\w)...\7...\7) |
         (?>^..(\w).\8.\8)
      )',
      Regexp::EXTENDED
    )

  !!(board =~ winning_moves)
end

Test.describe("Some boards with winners") do
  ["XXX-O-O-O", "X--OOOX-X", "O--OO-XXX", "O-XOX-O-X", "OXOOXOXX-", "X-O-OOXXO", "XO--X-OOX", "X-OXOOOXX"].each do |winner|
    it (winner) do
      Test.assert_equals(regex_tic_tac_toe_win_checker(winner), true)
    end
  end
end

Test.describe("Some boards without winners") do
  ["XO-------", "XX-XOO---", "-XX-OO-O-", "OXO--XXO-", "OOXXXO---", "OXXX-XOO-", "OOXXX----", "XXOOXXOO-", "OXOXOX---"].each do |not_winner|
    it (not_winner) do
      Test.assert_equals(regex_tic_tac_toe_win_checker(not_winner), false)
    end
  end
end
