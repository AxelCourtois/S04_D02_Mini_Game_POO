require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

EMOJI_CACA = "\u{1F4A9}"
COLOR_GREEN = "\033[92m"
COLOR_PINK = "\033[95m"
COLOR_END = "\033[0m"
BOLD = "\033[1m"
BOLD_YELLOW = "\e[1;33m"

def display_pyramide (height_pyramide, caracter_display, is_emoji)
  space = 1
  
  if is_emoji == true
    space = 2
  end 
  
    height_pyramide.times do |x|
      puts " " * (height_pyramide - x) * space + caracter_display * (x * 2 + 1)
    end
end


def loading 
  spinner = Enumerator.new do |e|
    loop do
      e.yield '|'
      e.yield '/'
      e.yield '-'
      e.yield '\\'
    end
  end
  1.upto(100) do |i|
    progress = "=" * (i/5) unless i < 5
    printf("\rLOADING: [%-20s] %d%% %s", progress, i, spinner.next)
    sleep(0.02)
  end
end

def loading_2(player1, player2, player3)
  1.upto(100) do |i|
    printf("\rLOADING: %d%%", i)
    sleep(0.07)
    if i == 10
      puts "  -> Initialisation des adversaires................................"
    elsif i == 20
      puts "  -> Réglement des comptes........................................."
    elsif i == 30
      puts "  -> #{player1.name} va faire ses courses.........................."
    elsif i == 40
      puts "  -> #{player2.name} entre en jeu........................................."
    elsif i == 50
      puts "  -> #{player2} à #{player2.life_points} points de vie.............................."
    elsif i == 60
      puts "  -> #{player3.name} #{player3} ......................................................"
    elsif i == 70
      puts "  -> #{player3.life_points} à.... initialisation.... points de vie #{player2}.............................."
    elsif i == 80
      puts "  -> #{player1.name} à cassé la machine.............................."
    elsif i == 90
      puts "  -> ........................................"
    elsif i == 100
      puts " -> DONE"
    end
  end
end

round = 0


# ---------------------------------------------------------------------------------

puts "\n"
loading
puts "\n\n\n\n"


puts BOLD_YELLOW + "-----------------------------------------"
puts "| STAY ALIVE (comme dirait les BeeGees) |"
puts "-----------------------------------------" + COLOR_END
puts "\n"



puts "Rentre ton nom d'utilisateur : "
print "> "
user_player = gets.chomp
player_human = HumanPlayer.new(user_player)
player2 = Player.new("Sam la merguez")
player3 = Player.new("Alex la chipo")
array_player = [player2, player3]



puts "\n\n"

loading_2(player_human, player2, player3)

puts "\n\n"



puts BOLD_YELLOW + "----------------------------------------------------"
puts "|  Les règles du jeu sont simples : BATTLEROYAL    |"
puts "| Sois le dernier survivant parmis les adversaires |"
puts "----------------------------------------------------" + COLOR_END
puts "\n"


puts BOLD + "Tu peux choisir une action en début de partie et après chaque round, que seront :"
sleep(0.3)
puts "- ATK 1 (#{player2.name})" 
sleep(0.3)
puts "- ATK 2 (#{player3.name})"
sleep(0.3)
puts "- HEAL"
sleep(0.3)
puts "- WEAPON" + COLOR_END
sleep(0.5)

puts "\n\n"

puts "Tape GO pour lancer la partie !"
loop do 
  print "> "
  user_go_input = gets.chomp.downcase
  case user_go_input
  when "go"
    break
  else  
    puts "GO je t'ai dit"
  end
end
puts "\n\n"
puts BOLD + "-------------------------------- Commençons à jouer ! --------------------------------"
puts "\n"
sleep(0.1)
puts "Nos trois grands champions sont :" 
sleep(1)
puts "-> #{player_human.name} avec #{player_human.life_points} points de vie (cheater t'es en mode ultra facile)" 
sleep(1)
puts "-> #{player2.name} avec #{player2.life_points} points de vie" 
sleep(1)
puts "-> #{player3.name} avec #{player3.life_points} points de vie"  + COLOR_END
puts "\n\n"
sleep(1)


while player_human.life_points >0 && (player2.life_points > 0 || player3.life_points >0)
  round += 1


  puts BOLD_YELLOW + "-----------"
  puts "| ROUND #{round} |"
  puts "-----------" + COLOR_END
  sleep(1)
  puts "\n" + COLOR_GREEN
  player_human.show_state
  puts "\n"
  player2.show_state
  player3.show_state 
  puts "\n" + COLOR_END


  loop do 
    sleep(1)
    puts "Choisis une action (atk, heal, weapon) :"
    print "> " + COLOR_GREEN
    user_action = gets.chomp.downcase 
    case user_action
      when "atk 1"
        sleep(0.5)
        puts "\n"
        player_human.attacks(player2)
        sleep(3)
        break
      when "atk 2"
        sleep(0.5)
        puts "\n"
        player_human.attacks(player3)
        sleep(3)
        break
      when "heal"
        sleep(0.5)
        puts "\n"
        player_human.search_health_pack
        sleep(3)
        break
      when "weapon"
        sleep(0.5)
        puts "\n"
        player_human.search_weapon
        sleep(3)
        break
      else  
        puts "\n"
        puts "ATTENTION Tu dois choisir une action valide : attack bot 1, attack bot 2, heal, new weapon"
    end
  end
  puts "\n\n" + COLOR_END
  puts COLOR_PINK + "-> Au tour de tes adversaires... <-"
  puts "\n"
  COLOR_PINK
  array_player.each do |player|
    if player.life_points > 0
      player.attacks(player_human)
      puts "\n"
    else 
      puts "#{player.name} s'est enfoui sous terre et ne peut pas attaquer."
      puts "\n" 
    end
  end
  sleep(2)
  puts "\n\n\n" + COLOR_END
end

puts "         FELICITATION"
puts "\n"
display_pyramide(7, EMOJI_CACA, true)
puts "\n"
puts "Tu as vaincu #{player2.name} et #{player3.name}"














