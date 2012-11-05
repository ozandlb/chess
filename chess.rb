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

    # set turn
    @whoseturn = @white

    @movenumber = 0
  end


end # class Game




class Player
  attr_reader :color, :toporbottom, :pieces
  attr_accessor :movescount

  def initialize(color, toporbottom)
    @color = color
    @movescount = 0
    @toporbottom = toporbottom
  end

  def setpieces(game)
    @columns = 8
    if @toporbottom == :bottom
      @rowstart = 1
      @rowend = 2
    elsif @toporbottom == :top
      @rowstart = 7
      @rowend = 8 
    end

    @pieces = Hash.new

    for @i in 1..@columns do
      for @j in @rowstart..@rowend do
        @pieces[[@i,@j]] = Piece.new(game.board.squares[[@i,@j]], self)
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

    for @i in 1..@columns do
      for @j in 1..@rows do
        @squares[[@i,@j]] = Square.new(@i, @j)
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


  def targetlegal(game, targetsquare)

    #  validate pawn movements
    #  =========  NOTE: OPTIONS BELOW DO NOT CHECK FOR / VALIDATE EN PASSANT CAPTURES  ========
    #  =========  NOTE: OPTIONS BELOW DO NOT CHECK FOR & BLOCK MOVES THAT LEAVE KING IN CHECK  ========
    if @type == :pawn     

      # calibrate counter for whether player is on top or bottom
      if @player.toporbottom == :top
        @rowfactor = -1
      elsif @player.toporbottom == :bottom
        @rowfactor = 1
      end

      # one move straight ahead
      if targetsquare.column == @currentsquare.column &&
        targetsquare.row == @currentsquare.row + @rowfactor && 
        targetsquare.currentpiece == nil
        return true

        # two moves ahead from starting position
      elsif targetsquare.column == @currentsquare.column && 
        targetsquare.row == @currentsquare.row + (2 * @rowfactor) && 
        targetsquare.currentpiece == nil && 
        game.board.squares[[@currentsquare.column, @currentsquare.row + @rowfactor]].currentpiece == nil 
        return true

        # capture move
      elsif
        (targetsquare.column == @currentsquare.column + 1 || 
        targetsquare.column == @currentsquare.column - 1) && 
        targetsquare.row == @currentsquare.row + @rowfactor && 
        targetsquare.currentpiece != nil && 
        targetsquare.currentpiece.color != self.color
        return true

      else
        return false

      end #if 

    end#if for pawns

  end # target


  def forcemove(game, targetsquare)

    # update player pieces
    @player.pieces[[targetsquare.column, targetsquare.row]] = self
    @player.pieces[[@currentsquare.column, @currentsquare.row]] = nil
    #@player.pieces.delete [[@currentsquare.column, @currentsquare.row]]

    #update board squares
    targetsquare.currentpiece = self
    @currentsquare.currentpiece = nil
    
    #update currentsquare
    @currentsquare = targetsquare    
    
  end # forcemove


  def move(game, targetsquare)

    if self.targetlegal(game, targetsquare) == true

      self.forcemove(game, targetsquare)

      # increase the move numbers for piece, player and game
      @movenumber += 1
      @player.movescount += 1
      game.movenumber += 1

    end # if
  end # forcemove


end # class Piece



