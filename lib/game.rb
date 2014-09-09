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
    system "clear"

    @game_running = true
    @output.put_message("Game started")
    @output.put_message(" 0 1 2 3 4 5 6 ")

    draw_board
    
    put_prompt
  end

  def play(column)
    raise_if_invalid_column(column)
    raise_if_column_is_full(column)
    raise_if_game_is_not_running

    update_column(column)

    system "clear"

    @output.put_message(" 0 1 2 3 4 5 6 ")
    draw_board

    if is_win?
      @output.put_message("Player #{@current_player} wins")
      @game_running = false
      return
    end    

    change_player
    @current_turn+=1;
    put_prompt
  end

  def slot(row, col)
    @board[row][col]
  end

private

  def draw_board
    for row in 5.step(0, -1) do
      for col in (0..6) do
        @output.put_vertical_separator

        if @board[row][col] == 1
          @output.put_player1_disc
        elsif @board[row][col] == 2
          @output.put_player2_disc
        else
          @output.put_empty_space
        end
      end

      @output.put_vertical_separator
      @output.put_message("")
    end
  end

  def is_win?
    if @current_turn >= 7
      if is_horizontal_win? || is_vertical_win?
        return true
      end
    end

    return false
  end

  def is_horizontal_win?
    (0..@columns_heights.max - 1).each do |row|
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

  def is_vertical_win?
    (0..6).each do |col|
      win = 0
      (0..5).each do |row| 
        slot(row, col) == @current_player ? win += 1 : win = 0
        if win == 4          
          return true
        end
      end
    end  

    false  
  end

  def is_oblique_win?
    (0..2).each do |col|
      win = 0
      (0..3).each do |row| 
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