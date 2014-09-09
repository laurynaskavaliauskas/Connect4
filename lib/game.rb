class Game
  attr_reader :current_player
  attr_reader :current_turn

  def initialize(output)
    @output = output
    @current_player = 1;
    @current_turn = 1;
  end
  
  def start
    @output.put_message("Game started")
    put_prompt
  end

  def play(column)
    raise_if_invalid_column(column)

    change_player
    @current_turn+=1;
    put_prompt
  end

private

  def raise_if_invalid_column(column)
    if column < 0 || column > 6
      raise ArgumentError
    end
  end

  def change_player
    @current_player = @current_player == 1 ? 2 : 1;
  end

  def put_prompt
    @output.put_message("Player #{current_player}: select column")
  end
end