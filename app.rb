require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


round = 0

player1 = Player.new("Axel la force tranquille")
player2 = Player.new("Sam la merguez")
puts "\n"
puts "Nos deux grands champions sont :" 
puts "- #{player1.name}" 
puts "- #{player2.name}"


while player1.life_points > 0 && player2.life_points > 0 
  round += 1
  puts "\n\n"
  puts "-----------"
  puts "| ROUND #{round} |"
  puts "-----------"
  # puts "\n"
  # puts "Voici l'état des joueurs :"
  # puts "\n"
  # puts "#{player1.name} à #{player1.life_points} point(s) de vie"
  # puts "#{player2.name} à #{player2.life_points} point(s) de vie"
  puts "\n"
  puts "-> Phase d'attaque :"
  puts "\n"
  player1.attacks(player2)
  if player2.life_points <= 0
    break
  else  
    puts "\n"
    player2.attacks(player1)
  end
end
