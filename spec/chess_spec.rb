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
      @square = Square.new(1, 1)
    end

    it "returns a Square object" do
      @square.should be_an_instance_of Square
    end

    describe "black square" do

      before :each do
        @black = Player.new(:black, :top)
        @white = Player.new(:white, :bottom)
        @startingsquare = Square.new(1, 1) 
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
      @startingsquare = Square.new(1, 1)
      @currentsquare = @startingsquare
      @piece = Piece.new(@startingsquare, @white)
    end

    it "returns a Piece object" do
      @piece.should be_an_instance_of Piece
    end

    it "should have a movenumber of zero" do
      @piece.movenumber.should == 0
    end
  end

  describe "target one square forward" do

    before do
      @g = Game.new
      @targetsquare = @g.board.squares[[1,3]]
    end

    it "should be legal" do
      @g.white.pieces[[1,2]].targetlegal(@targetsquare).should == true
    end

  end #target one square forward


  describe "target two squares forward" do

    before do
      @g = Game.new
      @targetsquare = @g.board.squares[[1,4]]
    end

    it "should be legal" do
      @g.white.pieces[[1,2]].targetlegal(@targetsquare).should == true
    end

  end #target two squares forward


  describe "bad target two squares to the side" do

    before do
      @g = Game.new
      @targetsquare = @g.board.squares[[3,3]]
    end

    it "should not be legal" do
      @g.white.pieces[[1,2]].targetlegal(@targetsquare).should == false
    end

  end #target two squares forward



end #class Piece






describe Move do

  describe "#new" do

    before :each do
      @black = Player.new(:black, :top)
      @white = Player.new(:white, :bottom)
      @target = Square.new(1,2) 
      @move = Move.new(@target)
    end

    it "returns a Move object" do
      @move.should be_an_instance_of Move
    end
  end

end # class Move





describe Player do

  describe "#new" do

    before do
      @black = Player.new(:black, :top)
    end

    it "returns a Player object" do
      @black.should be_an_instance_of Player
    end

  end # new


  describe "setpieces" do

    before do
      @g=Game.new
    end

    it "should be of the correct type" do
      @g.black.pieces[[1,8]].type.should == :rook
    end #should be of the correct type

  end # setpieces


end # class Player





