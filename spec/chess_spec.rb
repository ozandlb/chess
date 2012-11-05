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
      @square = Square.new(1, 1)
    end

    it "returns a Square object" do
      @square.should be_an_instance_of Square
    end

    describe "black square" do

      before :each do
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

  describe "#targetlegal" do

    before :each do
      @g = Game.new
    end


    describe "target one square forward for bottom pawn" do

      before do
        @targetsquare = @g.board.squares[[1,3]]
      end

      it "should be legal" do
        @g.white.pieces[[1,2]].targetlegal(@g, @targetsquare).should == true
      end

    end #target one square forward for bottom pawn


    describe "target one square forward for top pawn" do

      before do
        @targetsquare = @g.board.squares[[1,6]]
      end

      it "should be legal" do
        @g.black.pieces[[1,7]].targetlegal(@g, @targetsquare).should == true
      end

    end #target one square forward for top pawn



    describe "target two squares forward with no obstruction for bottom pawn" do

      before do
        @targetsquare = @g.board.squares[[1,4]]
      end

      it "should be legal" do
        @g.white.pieces[[1,2]].targetlegal(@g, @targetsquare).should == true
      end

    end #target two squares forward with no obstruction for bottom pawn



    describe "target two squares forward with no obstruction for top pawn" do

      before do
        @targetsquare = @g.board.squares[[1,5]]
      end

      it "should be legal" do
        @g.black.pieces[[1,7]].targetlegal(@g, @targetsquare).should == true
      end

    end #target two squares forward with no obstruction for top pawn



    describe "target three squares forward with no obstruction for bottom pawn" do

      before do
        @targetsquare = @g.board.squares[[1,5]]
      end

      it "should not be legal" do
        @g.white.pieces[[1,2]].targetlegal(@g, @targetsquare).should == false
      end

    end #target two squares forward with no obstruction for bottom pawn



    describe "target three squares forward with no obstruction for top pawn" do

      before do
        @targetsquare = @g.board.squares[[1,4]]
      end

      it "should not be legal" do
        @g.black.pieces[[1,7]].targetlegal(@g, @targetsquare).should == false
      end

    end #target two squares forward with no obstruction for top pawn





    describe "target two squares forward with obstruction for bottom pawn" do

      before do
        @g.black.pieces[[1,7]].forcemove(@g, @g.board.squares[[1,3]])
        @targetsquare = @g.board.squares[[1,4]]
      end

      it "should not be legal" do
        @g.white.pieces[[1,2]].targetlegal(@g, @targetsquare).should == false
      end

    end #target two squares forward with obstruction for bottom pawn




    describe "target two squares forward with obstruction for top pawn" do

      before do
        @g.white.pieces[[1,2]].forcemove(@g, @g.board.squares[[1,6]])
        @targetsquare = @g.board.squares[[1,5]]
      end

      it "should not be legal" do
        @g.black.pieces[[1,7]].targetlegal(@g, @targetsquare).should == false
      end

    end #target two squares forward with obstruction for top pawn




    describe "target one square forward for capture for bottom pawn" do

      before do
        @g.black.pieces[[2,7]].forcemove(@g, @g.board.squares[[2,3]])
        @targetsquare = @g.board.squares[[2,3]]
      end

      it "should be legal" do
        @g.white.pieces[[1,2]].targetlegal(@g, @targetsquare).should == true
      end

    end #target two squares forward with obstruction for bottom pawn




    describe "target one square forward for capture for top pawn" do

      before do
        @g.white.pieces[[2,2]].forcemove(@g, @g.board.squares[[2,6]])
        @targetsquare = @g.board.squares[[2,6]]
      end

      it "should be legal" do
        @g.black.pieces[[1,7]].targetlegal(@g, @targetsquare).should == true
      end

    end #target two squares forward with obstruction for bottom pawn




    describe "bad target two squares to the side for bottom pawn" do

      before do
        @targetsquare = @g.board.squares[[3,3]]
      end

      it "should not be legal" do
        @g.white.pieces[[1,2]].targetlegal(@g, @targetsquare).should == false
      end

    end #target two squares forward for bottom pawn



    describe "bad target two squares to the side for top pawn" do

      before do
        @targetsquare = @g.board.squares[[3,5]]
      end

      it "should not be legal" do
        @g.black.pieces[[1,7]].targetlegal(@g, @targetsquare).should == false
      end

    end #target two squares forward for top pawn


  end #targetlegal for pawn



  describe "#move" do
    
    before do
      @g = Game.new
      @g.black.pieces[[1,7]].move(@g, @g.board.squares[[1,6]])
    end

    it "should update currentpiece" do
      @g.board.squares[[1,7]].currentpiece.should == nil
      @g.board.squares[[1,6]].currentpiece.should_not == nil
    end    

    it "should update coordinates" do
      @g.black.pieces[[1,7]].should == nil
      @g.black.pieces[[1,6]].should_not == nil
    end    

    #it "player should still have 16 pieces" do
    #  @g.black.pieces.count.should == 16
    #end    

  end # move


end #class Piece





describe Player do

  describe "#new" do

    before do
      @black = Player.new(:black, :top)
      @white = Player.new(:white, :bottom)
    end

    it "returns a Player object" do
      @black.should be_an_instance_of Player
      @white.should be_an_instance_of Player
    end
    
    it "movescount should be 0" do
      @black.movescount.should == 0
      @white.movescount.should == 0
    end

  end # new


  describe "#setpieces" do

    before do
      @g=Game.new
    end

    it "should be of the correct type" do

      for @i in 1..8 do
        @g.black.pieces[[@i,7]].type.should == :pawn
      end
      @g.black.pieces[[1,8]].type.should == :rook
      @g.black.pieces[[2,8]].type.should == :knight
      @g.black.pieces[[3,8]].type.should == :bishop
      @g.black.pieces[[4,8]].type.should == :queen
      @g.black.pieces[[5,8]].type.should == :king
      @g.black.pieces[[6,8]].type.should == :bishop
      @g.black.pieces[[7,8]].type.should == :knight
      @g.black.pieces[[8,8]].type.should == :rook

      for @i in 1..8 do
        @g.white.pieces[[@i,2]].type.should == :pawn
      end
      @g.white.pieces[[1,1]].type.should == :rook
      @g.white.pieces[[2,1]].type.should == :knight
      @g.white.pieces[[3,1]].type.should == :bishop
      @g.white.pieces[[4,1]].type.should == :queen
      @g.white.pieces[[5,1]].type.should == :king
      @g.white.pieces[[6,1]].type.should == :bishop
      @g.white.pieces[[7,1]].type.should == :knight
      @g.white.pieces[[8,1]].type.should == :rook

    end #should be of the correct type

  end # setpieces


end # class Player





