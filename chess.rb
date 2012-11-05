class Game

  attr_accessor :white, :black, :movenumber, :board, :whoseturn, :movenumber


  def initialize

    # set up black and white players, with black on top
    @black = Player.new(:black, :top)
    @white = Player.new(:white, :bottom)

    # initialize board with black on top
    @board = Board.new(@black, @white)
    
    # initialize pieces 
    @black.setpieces(self)
    @white.setpieces(self)

    # white always goes first
    @whoseturn = @white

    @movenumber = 0
  end


end # class Game




class Player
  attr_reader :color, :toporbottom, :movescount, :pieces

  def initialize(color, toporbottom)
    @color = color
    @movescount = 0
    @toporbottom = toporbottom
  end

  def setpieces(game)
    @columns = 8
    @rows = 2

    @pieces = Hash.new

    for @j in 1..@columns do
      for @i in 1..@rows do
        @pieces[[@j,@i]] = Piece.new(game.board.squares[[@j,@i]], self)
      end
    end
    
  end # setpieces

end # class Player





class Board
  attr_reader :columns, :rows, :squares, :topplayer, :bottomplayer

  def initialize(topplayer, bottomplayer)
    @columns = 8
    @rows = 8
    @topplayer = topplayer
    @bottomplayer = bottomplayer
    self.setsquares
  end

  def setsquares

    @squares = Hash.new

    for @j in 1..@columns do
      for @i in 1..@rows do
        @squares[[@j,@i]] = Square.new(@i, @j)
      end
    end

  end # setsquares

end # class Board





class Square


  attr_accessor :column, :row, :color, :currentpiece

  def initialize (column, row)
    @column = column
    @row = row
    self.setcolor
  end


  def setcolor
    if (@row.odd? && @column.odd?) || (@row.even? && @column.even?)
      @color = :black
    else
      @color = :white
    end
  end # setcolor


end # class Square




class Piece
  attr_accessor :startingsquare, :currentsquare, :color, :movenumber, :player, :type

  def initialize(startingsquare, player)
    @startingsquare = startingsquare
    @currentsquare = startingsquare
    @player = player
    @color = @player.color
    self.settype
    @movenumber = 0
    self.updatesquarestatus
  end

  def settype
    if @startingsquare.row == 2 || @startingsquare.row == 7
      @type = :pawn
    elsif @startingsquare.row == 1 || @startingsquare.row == 8
      if @startingsquare.column == 1 || @startingsquare.column == 8
        @type = :rook
      elsif @startingsquare.column == 2 || @startingsquare.column == 7
        @type = :knight
      elsif @startingsquare.column == 3 || @startingsquare.column == 6
        @type = :bishop
      elsif @startingsquare.column == 4
        @type = :queen
      elsif @startingsquare.column == 5
        @type = :king
      end
    end
  end
  
  
  def updatesquarestatus
    @currentsquare.currentpiece = self
  end #updatesquarestatus

end # class Piece





class Move
  attr_accessor :target, :movenumber

  def initialize(target)
    @target = target		
  end

  def legal?
  end

end # class Move


