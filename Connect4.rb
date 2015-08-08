$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'connect4'

system "clear"

puts "This is a demo Connect 4 game created by Laurynas Kavaliauskas"
puts
puts "Command line usage instructions"
puts
puts "\033[31m$ruby Connect4.rb \033[0m"
puts
puts "or"
puts
puts "\033[31m$ruby Connect4.rb height width count\033[0m"
puts 
puts "\033[31mheight\033[0m is a custom board height (number)"
puts "\033[31mwidth\033[0m is a custom board width (number)"
puts "\033[31mcount\033[0m is a number of pieces that must be adjacent to win the game"
puts 
puts "Ready to start? (y/n)"

continue = gets.chomp
if !(continue == 'y' || continue == 'Y')
	exit
end

game = Game.new(ARGV[0], ARGV[1], ARGV[2], ConsolePrinter.new(STDOUT))
game.start

loop do
  i = gets.chomp

  if i.empty?
    exit
  end

  game.play(i.to_i)
end
