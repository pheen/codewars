def snail(row_arr)
  row_contents = row_arr.flatten
  return [] if row_contents.empty?
  return [row_arr[0][0]] if row_contents.count == 1

  result = []
  offset = row_arr.count - 1
  depth  = 1

  result << row_arr[0][0]
  # [x][ ][ ]
  # [ ][ ][ ]
  # [ ][ ][ ]

  while :snailing_away
    slimey_depth  = depth != 1 && offset.odd? ? depth - 1 : depth
    slimey_offset = depth > 1 ? 1 : 0
    top_row_range = (depth - slimey_offset..(offset - depth))

    break if top_row_range.last < 0

    top_row_range.each do |n|
      r = depth - 1
      c = n
      result << row_arr[r][c]
    end
    # [x][x][ ]
    # [ ][ ][ ]
    # [ ][ ][ ]

    (-1 + depth..(offset + 1) - depth).each do |n|
      r = n
      c = 0 - depth
      result << row_arr[r][c]
    end
    # [x][x][x]
    # [ ][ ][x]
    # [ ][ ][x]

    (-1 - depth).downto(-offset + (depth - 1)).each do |n|
      r = -depth
      c = n
      result << row_arr[r][c]
    end
    # [x][x][x]
    # [ ][ ][x]
    # [ ][x][x]

    (0 - depth).downto(-offset + (depth - 1)).each do |n|
      r = n
      c = depth - 1
      result << row_arr[r][c]
    end
    # [x][x][x]
    # [x][ ][x]
    # [x][x][x]

    depth += 1
  end

  result
end

def test input , expected
  output = snail(input)
  Test.expect(expected == output, "When snail(#{input}) expected #{expected} but got #{output}")
end

test( [[1,2,3],[4,5,6],[7,8,9]] , [1, 2, 3, 6, 9, 8, 7, 4, 5])
