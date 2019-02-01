class TicTacToe
  attr_reader :turn
  attr_reader :tictactoe
  attr_reader :stalemate

  def initialize
    @player1 = "X"
    @player2 = "O"
    @turn = "1"
    @tictactoe = false
    @stalemate = false
    @squares = {}
    @legal_moves = {}
    new_game_board
    set_legal_moves
  end

  def take_turn(reference)
    return illegal_input unless check_input(reference)
    check_square(reference)
  end

  private

  def new_game_board
    (1..9).each do |n|
      @squares[n.to_s.to_sym] = n
    end
    print_game_board
  end

  def set_legal_moves
    (1..9).each do |n|
      @legal_moves[n] = n.to_s
    end
  end

  def change_player_turn
    @turn == "1" ? @turn = "2" : @turn = "1"    
  end

  def check_input(reference)
    @legal_moves.each_value do |value|
      return true if reference == value
    end
    return false
  end

  def check_square(reference)
    return illegal_move if (@squares[reference.to_sym] == "X" || @squares[reference.to_sym] == "O")
    mark_square(reference)
  end

  def mark_square(reference)
    @squares[reference.to_sym] = @turn == "1" ? "X" : "O"
    print_game_board
    check_game_end
    check_tictactoe unless @stalemate
    change_player_turn unless @tictactoe
  end

  def check_tictactoe
    check_for = @turn == "1" ? @player1 : @player2
    winning_squares = { set1: [1, 2, 3],
                        set2: [4, 5, 6],
                        set3: [7, 8, 9],
                        set4: [1, 4, 7],
                        set5: [2, 5, 8],
                        set6: [3, 6, 9],
                        set7: [1, 5, 9],
                        set8: [3, 5, 7] }
    winning_squares.each_value do |value|
      count = 0
      value.each do |v|
        break unless check_for == @squares[v.to_s.to_sym]
        count += 1
        if (count == 3)
          @tictactoe = true
          return
        end
      end
    end
  end

  def check_game_end
    @squares.each_value do |v|
      return unless (v == "X" || v == "O")
    end
    @stalemate = true
  end

  def print_game_board
    count = 0
    @squares.each_value do |v|
      puts "\n" if count % 3 == 0
      print "#{@squares[:"#{(count += 1).to_s}"]} "
      print "| " unless count % 3 == 0
    end
    print "\n"
  end

  def illegal_move
    print "\nThat space is already taken!"
  end
  
  def illegal_input
    print "\nInvalid move."
  end

end
