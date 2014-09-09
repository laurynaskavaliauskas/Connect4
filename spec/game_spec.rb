require "spec_helper"

describe Game do

  before :each do 
    @output = ConsolePrinter.new(Output.new).as_null_object
    @game = Game.new(@output)
  end

  def expect_output_message(message)
    @output.should_receive(:put_message).with(message)
  end

  def player1_wins
    (0..2).each{|col| 2.times { @game.play(col) }}
    @game.play(3)
  end

  describe "#new" do 
    context "with an output" do
      it "creates a new game instance" do 
        @game.should be_a Game
      end

      it "set player 1 as starting player" do
        @game.current_player.should == 1
      end
    end
  end

  describe "#start" do 
    it "shows a start message to the user" do
      expect_output_message("Game started")
      @game.start
    end

    it "prompts player 1 to make the first move" do
      expect_output_message("Player 1: select column")
      @game.start
    end

    it "set player 1 as starting player" do
      @game.current_player.should == 1
    end

    it "sets current turn to 1" do
      @game.current_turn.should == 1
    end

    it "initializes the slots to 0" do
      (0..5).each{|row| (0..6).each{|col| @game.slot(row, col).should == 0}}
    end
  end

  describe "#play" do
    before :each do 
      @game.start
    end

    it "doesn't accept invalid columns" do
      expect{@game.play(-1)}.to raise_error ArgumentError
      expect{@game.play(7)}.to raise_error ArgumentError
    end

    context "with an invalid column" do
      before :each do
        begin
          @game.play(7)
        rescue   
        end        
      end

      it "doesn't change player" do
        @game.current_player.should == 1
      end

      it "doesn't change turn" do
        @game.current_turn.should == 1
      end
    end    

    it "after Player 1 plays asks Player 2 for next move" do
      expect_output_message("Player 2: select column")
      @game.play(1)
    end

    context "Player 1 makes the first move" do
      before :each do 
        @game.play(1)
      end

      it "set player 2 as current player" do
        @game.current_player.should == 2
      end     

      it "sets turn to 2" do
        @game.current_turn.should == 2
      end

      it "fills the correct slot" do
        @game.slot(0, 1).should == 1
      end

      it "after Player 2 plays asks Player 1 for next move" do
        expect_output_message("Player 1: select column")
        @game.play(1)
      end

      context "Player 2 makes the second move" do
        before :each do 
          @game.play(1)
        end

        it "set player 1 as current player" do
          @game.current_player.should == 1
        end      

        it "sets turn to 3" do
          @game.current_turn.should == 3
        end    

        it "fills the correct slot" do
          @game.slot(0, 1).should == 1
          @game.slot(1, 1).should == 2
        end
      end
    end

    it "raises an error when the column is full" do
      6.times{@game.play(1)}
      expect{@game.play(1)}.to raise_error ArgumentError
    end

    it "raises an error if game has ended" do
      player1_wins
      expect{@game.play(1)}.to raise_error
    end
  end

  it "ends when a player wins" do
    @game.start
    expect_output_message("Player 1 wins")
    player1_wins
  end
end
