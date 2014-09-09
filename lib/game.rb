class Game
  attr_reader :current_player
  attr_reader :current_turn

  def initialize(output)
    @output = output
    @current_player = 1;
    @current_turn = 1;
    @board = Array.new(6) {Array.new(7, 0) }
    @columns_heights = Array.new(7, 0)
    @game_running = false
  end
  
  def start
    @game_running = true
    @output.put_message("Game started")
    put_prompt
  end

  def play(column)
    raise_if_invalid_column(column)
    raise_if_column_is_full(column)
    raise_if_game_is_not_running

    update_column(column)

    if @current_turn >= 7
      if is_horizontal_win?
        @output.put_message("Player #{@current_player} wins")
        @game_running = false
        return
      end
    end    

    change_player
    @current_turn+=1;
    put_prompt
  end

  def slot(row, col)
    @board[row][col]
  end

private

  def is_horizontal_win?
    (0..@columns_heights.max).each do |row|
      win = 0
      (0..6).each do |col| 
        slot(row, col) == @current_player ? win += 1 : win = 0
        if win == 4          
          return true
        end
      end
    end  

    false  
  end

  def raise_if_invalid_column(column)
    if column_is_invalid?(column)
      raise ArgumentError
    end
  end

  def column_is_invalid?(column)
    column < 0 || column > 6
  end

  def raise_if_column_is_full(column)
    if column_is_full?(column)
      raise ArgumentError
    end
  end

  def column_is_full?(column)
    @columns_heights[column] >= 6
  end

  def raise_if_game_is_not_running
    raise Exception if @game_running == false
  end

  def change_player
    @current_player = @current_player == 1 ? 2 : 1;
  end

  def put_prompt
    @output.put_message("Player #{current_player}: select column")
  end

  def update_column(column)
    fill_board_slot(column)
    @columns_heights[column] += 1
  end

  def fill_board_slot(column)
    @board[@columns_heights[column]][column] = @current_player
  end
end