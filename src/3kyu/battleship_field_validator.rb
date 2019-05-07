def validate_battlefield(field)
  battleships = []
  orig_field = field.map { |rows|
    rows.map { |cols|
      cols
    }
  }

  field.each_with_index do |row, row_i|
    row.each_with_index do |col, col_i|
      next unless col == 1

      field[row_i][col_i] = 0
      x_size = 1
      y_size = 1

      ((col_i + 1) ... 10).each do |i|
        break unless field[row_i][i] == 1
        field[row_i][i] = 0
        x_size += 1
      end

      ((row_i + 1) ... 10).each do |i|
        break unless field[i][col_i] == 1
        field[i][col_i] = 0
        y_size += 1
      end

      boat = Boat.new(row_i, col_i, x_size, y_size)
      
      if boat.valid?
        battleships << boat
      else
        return false
      end
    end
  end

  p orig_field

  formation = BattleFormation.new(orig_field, battleships)
  formation.valid?
end

class BattleFormation
  def initialize(field, battleships)
    @field = field
    @ships = battleships
  end
  
  def valid?    
    return false unless @ships.select { |s| s.classification == :battleship }.length == 1
    return false unless @ships.select { |s| s.classification == :cruiser    }.length == 2
    return false unless @ships.select { |s| s.classification == :destroyer  }.length == 3
    return false unless @ships.select { |s| s.classification == :submarine  }.length == 4
    return false unless @ships.length == 10
    return false unless valid_proximity?
    true
  end
  
  def valid_proximity?
    @ships.each do |ship|
  	  nearby_cell_values = ship.nearby_cells.map { |row_i, col_i| @field[row_i][col_i] }
      return false unless nearby_cell_values.sum.zero?
    end
    
    true
  end
end

class Boat
  SIZES = {
    4 => :battleship,
    3 => :cruiser,
    2 => :destroyer,
    1 => :submarine
  }

  def initialize(row_i,col_i, x_size, y_size)
    @row_i = row_i
    @col_i = col_i
    @x_size = x_size
    @y_size = y_size
    @size = [x_size, y_size].max
  end

  def valid?
    return false if @x_size + @y_size < 2
    return false if @x_size + @y_size > 5
    return false if @x_size > 1 && @y_size > 1
    return false unless classification
    true
  end

  def nearby_cells
    @nearby_cells ||= ship_cells.map do |cell|
      perimiter_cells(cell) - ship_cells
    end.flatten(1).uniq
  end
  
  def ship_cells
    @cells ||=
      (@row_i ... @row_i + @y_size).map do |y|
        (@col_i ... @col_i + @x_size).map do |x|
          [y, x]
        end
      end.flatten(1)
  end

  def classification
    @classificaton ||= SIZES[@size]
  end
end

def perimiter_cells(cell)
  row_i = cell[0]
  col_i = cell[1]

  cells = [
    [row_i - 1, col_i - 1],
    [row_i - 1, col_i],
    [row_i - 1, col_i + 1],

    [row_i, col_i - 1],
    [row_i, col_i],
    [row_i, col_i + 1],

    [row_i + 1, col_i - 1],
    [row_i + 1, col_i],
    [row_i + 1, col_i + 1]
  ]
  
  cells.select do |cell|
    index_range = (0..9)
    index_range.include?(cell[0]) && index_range.include?(cell[1])
  end
end

describe "Sample test" do
  field = [[1, 0, 0, 0, 0, 1, 1, 0, 0, 0],
           [1, 0, 1, 0, 0, 0, 0, 0, 1, 0],
           [1, 0, 1, 0, 1, 1, 1, 0, 1, 0],
           [1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
           [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
           [0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
           [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
           [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
           [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
           [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
  Test.expect(validate_battlefield(field), "Nope, something is wrong!")
end
