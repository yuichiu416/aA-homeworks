class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14, [])
    for i in 0...14
      @cups[i] = [:stone, :stone, :stone, :stone] if i != 6 && i != 13
    end
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos > 13 || start_pos < 0
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = Array.new(@cups[start_pos].count, :stone)
    @cups[start_pos] = []
    current_player_name == "Erica" ? skip = 13 : skip = 6
    i = 0
    while !stones.empty?
      i += 1
      next if (i + start_pos) % 14 == skip
      @cups[(start_pos + i) % 14] << stones.shift
    end
    render
    next_turn((start_pos + i) % 14, current_player_name)
  end

  def next_turn(ending_cup_idx, current_player_name)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if @cups[ending_cup_idx].empty?
      return :switch
    elsif ending_cup_idx < 7
      if current_player_name == "Erica"  # on our side and not empty
        return :prompt
      else
        return :switch
      end
    else
      if current_player_name == "Erica" # on enemy side and not empty
        return ending_cup_idx
      else
        return :prompt
      end
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..6].all?(&:empty?) || @cups[7..-1].all?(&:empty?)
  end

  def winner
    erica = @cups[6].count
    james = @cups[13].count
    if erica == james
      return :draw
    else
      if erica > james
        return "Erica"
      else
        return "james"
      end
    end
  end
end
