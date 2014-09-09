require "colorize"

class ConsolePrinter
  @@output = nil;
  def self.get_output
    @@output || ConsolePrinter.new
  end

  def put_player1_disc
    puts "\u25cf".red
  end

  def put_player2_disc
    puts "\u25cf".yellow
  end

  def put_horizontal_separator
    puts "\u2015".blue #2500, 2501
  end

  def put_vertical_separator
    puts "\u2502".blue #2503 , 7C, 275A, 2759
  end

  def put_message(message)
    puts message
  end
end