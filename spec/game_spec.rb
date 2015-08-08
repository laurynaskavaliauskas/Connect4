require "spec_helper"

describe Game do
  #we want initiate this class before each test 
  before :each do 
    @output = ConsolePrinter.new(Output.new).as_null_object
    @game = Game.new(6, 7, 4, @output)
  end

  def expect_output_message(message)
    @output.should_receive(:put_message).with(message)
  end

  def player1_wins
    (0..2).each{|col| 2.times { @game.play(col) }}
    @game.play(3)
  end

  describe "#new" do
    #confim that we’ve indeed made a Game object
    context "with an output" do
      it "creates a new game instance" do 
        @game.should be_a Game
      end
      #confirm 1st player has been set as starting
      it "set player 1 as starting player" do
        @game.current_player.should == 1
      end
    end
  end

  describe "#start" do 
    #check our Board array has been indeed zeroed
    it "initializes the slots to 0" do
      (0..5).each{|row| (0..6).each{|col| @game.slot(row, col).should == 0}}
    end
  end

  describe "#play" do
    before :each do 
      @game.start
    end
    # validates error handling
    it "raises an error when the column is full" do
      6.times{@game.play(1)}
      expect{@game.play(1)}.to raise_error ArgumentError
    end
  end

  #test gameplay, horizontal line
  it "ends when a player wins horizontally" do
    @game.start
    expect_output_message("Player 1 wins")
    player1_wins
  end

  #test gameplay, diagonal line
  it "ends when a player wins diagonally" do
    @game.start
    expect_output_message("Player 1 wins")
    (0..1).each { |col| @game.play(col) }
    (1..2).each { |col| @game.play(col) }
    2.times{(2..3).each { |col| @game.play(col) }}
    [3,5,3].each { |col| @game.play(col) }
  end
end
