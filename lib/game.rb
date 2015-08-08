class Game
  attr_reader :current_player
  attr_reader :current_turn

  def initialize(arg1, arg2, arg3, output)
    @output = output
    @current_player = 1
    @current_turn = 1
    @board_h = arg1.to_i > 0 ? arg1 : 6
    @board_w = arg2.to_i > 0 ? arg2 : 7
    @win_num = arg3.to_i > 0 ? arg3 : 4
    @board = Array.new(@board_h) {Array.new(@board_w, 0) }
    @columns_heights = Array.new(@board_w, 0)
    @game_running = false
  end
  
  def start
    system "clear"

    @game_running = true
    @output.put_message("Game started")
    draw_board
    put_prompt
  end

  def play(column)
    raise_if_invalid_column(column)
    raise_if_column_is_full(column)
    raise_if_game_is_not_running

    update_column(column)

    system "clear"
    draw_board

    if is_win(column)
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
    board_header = ' '
    for col in (0..(@board_w - 1)) do
      board_header += col.to_s + ' '
    end
    @output.put_message(board_header)
    for row in (@board_h - 1).step(0, -1) do
      for col in (0..(@board_w - 1)) do
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

  def is_win(column)
    if @current_turn >= (2*@win_num -1)
      x = column
      y = @columns_heights[column] - 1
      if (check_up_down(x, y) == @win_num) || (check_left_right(x, y) == @win_num) || (check_top_left_diag(x, y) == @win_num) || (check_top_right_diag(x, y) == @win_num)
        return true
      end
    end\
    
    false
  end

  def check_up_down( x, y, count = 0)
    count = 1 + check_direction( x, y, 0, 1) + check_direction( x, y, 0, -1)
  end

  def check_left_right( x, y, count = 0)
    count = 1 + check_direction( x, y, 1, 0) + check_direction( x, y, -1, 0)
  end

  def check_top_left_diag( x, y, count = 0)
    count = 1 + check_direction( x, y, -1, 1) + check_direction( x, y, 1, -1)
  end

  def check_top_right_diag( x, y, count = 0)
    count = 1 + check_direction( x, y, 1, 1) + check_direction( x, y, -1, -1)
  end

  def check_direction( x, y, add_x, add_y, count = 0)
    if (slot( y + add_y, x + add_x) == @current_player) && (x + add_x >= 0) && (y + add_y >= 0)
      count +=1
      check_direction( x + add_x, y + add_y, add_x, add_y, count )
    else
      count
    end
  end

  def raise_if_invalid_column(column)
    if column_is_invalid?(column)
      raise ArgumentError
    end
  end

  def column_is_invalid?(column)
    column < 0 || column > (@board_w - 1)
  end

  def raise_if_column_is_full(column)
    if column_is_full?(column)
      raise ArgumentError
    end
  end

  def column_is_full?(column)
    @columns_heights[column] >= @board_h
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
