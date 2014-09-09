require "spec_helper"

describe ConsolePrinter do
  before :each do
    @out = Output.new
    @output = ConsolePrinter.new(@out)
  end

  describe "#new" do 
    it "return a new ConsolePrinter instance" do 
      @output.should be_a ConsolePrinter
    end
  end

  it "put player 1 disc" do
    @out.should_receive(:print)
    @output.put_player1_disc
  end

  it "put player 2 disc" do
    @out.should_receive(:print)
    @output.put_player2_disc
  end

  it "puts a horizontal separator" do
    @out.should_receive(:print)
    @output.put_horizontal_separator
  end

  it "puts a vertical separator" do
    @out.should_receive(:print)
    @output.put_vertical_separator
  end

  it "puts a string" do     
    @out.should_receive(:puts).with("test string")
    @output.put_message("test string")
  end
end
