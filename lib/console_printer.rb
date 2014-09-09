require "colorize"

class ConsolePrinter

  def initialize(output)
    @output = output
  end

  def put_player1_disc
    @output.print "\u25cf".red
  end

  def put_player2_disc
    @output.print "\u25cf".yellow
  end

  def put_empty_space
    @output.print " "
  end

  def put_horizontal_separator
    @output.print "\u2015".blue #2500, 2501
  end

  def put_vertical_separator
    @output.print "\u2502".blue #2503 , 7C, 275A, 2759
  end

  def put_message(message)
    @output.puts message
  end
end