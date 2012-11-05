require_relative '../chess'
require 'yaml'



describe Game do

  describe "#new" do

    before :each do
      @game = Game.new
    end

    it "returns a Game object" do
      @game.should be_an_instance_of Game
    end
  end

end #class Game




describe Board do

  before :each do
    @black = Player.new(:black, :top)
    @white = Player.new(:white, :bottom)
    @board = Board.new(@black, @white)
  end

  describe "#new" do
    it "returns a Board object" do
      @board.should be_an_instance_of Board
    end

    it "has 64 squares" do
      @board.squares.count.should == 64
    end

  end

end #class Board





describe Square do

  describe "#new" do

    before :all do
      @black = Player.new(:black, :top)
      @white = Player.new(:white, :bottom)
      @square = Square.new(1, 1, @black, @white)
    end

    it "returns a Square object" do
      @square.should be_an_instance_of Square
    end

    describe "black square" do

      before :each do
        @black = Player.new(:black, :top)
        @white = Player.new(:white, :bottom)
        @startingsquare = Square.new(1, 1, @black, @white)
      end

      it "should be black" do
        @square.color.should == :black
      end

    end #black square

  end

end #class Piece





describe Piece do

  describe "#new" do

    before :each do
      @black = Player.new(:black, :top)
      @white = Player.new(:white, :bottom)
      @startingsquare = Square.new(1, 1, @black, @white)
      @currentsquare = @startingsquare
      @piece = Piece.new(@startingsquare, @currentsquare, @white)
    end

    it "returns a Piece object" do
      @piece.should be_an_instance_of Piece
    end

    it "should have a movenumber of zero" do
      @piece.movenumber.should == 0
    end
  end

end #class Piece






describe Move do

  describe "#new" do

    before :each do
      @black = Player.new(:black, :top)
      @white = Player.new(:white, :bottom)
      @target = Square.new(1,2, @black, @white)
      @move = Move.new(@target)
    end

    it "returns a Move object" do
      @move.should be_an_instance_of Move
    end
  end

end #class Move





describe Player do

  describe "#new" do

    before do
      @black = Player.new(:black, :top)
    end

    it "returns a Player object" do
      @black.should be_an_instance_of Player
    end
  end

end #class Move





