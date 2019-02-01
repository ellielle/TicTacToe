require_relative 'tic_tac_toe'

game = TicTacToe.new

loop do
  break if (game.tictactoe == true || game.stalemate == true)

  puts "\n#{game.turn == "1" ? "Player 1" : "Player 2"}\'s turn, enter a space to take: "
  move = gets.chomp
  game.take_turn(move)
end

puts game.turn == "1" ? "\nPlayer 1 wins!" : "\nPlayer 2 wins!" if game.tictactoe == true
if (game.tictactoe == false)
  puts "No one wins! Press ENTER to exit."
  gets
end