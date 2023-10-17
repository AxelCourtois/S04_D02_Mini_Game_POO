require 'pry'



class Player 
  attr_accessor :name, :life_points

  def initialize(name, life_points = 10)
    @name = name.to_s
    @life_points = life_points
  end


  def show_state 
    if @life_points <= 0
      puts "#{name} est DCD (gros bouffon)."
    else
      puts "#{name} à encore #{life_points} point(s) de vie."
    end
  end


  def gets_damage(damage)
    if damage >= @life_points
      puts "Il prend #{damage} et... GAME OVER #{name} décède (gros bouffon)."
      @life_points = 0
    else  
      @life_points -= damage
      puts "#{name} perd #{damage} point(s) de vie. Il te reste #{life_points} point(s) de vie."
    end
  end


  def compute_damage
    return rand(1..6)
  end

  def attacks(other_player)
    puts "#{name} attaque #{other_player.name} OMG!"
    rand_attack = compute_damage  
    other_player.gets_damage(rand_attack)
  end
end


class HumanPlayer < Player
  attr_accessor :name, :life_points, :weapon_level

  def initialize(name, life_points = 100, weapon_level = 1)
    @weapon_level = weapon_level.to_i
    super(name, life_points)
  end

  def show_state 
    if @life_points <= 0
      puts "#{name} est DCD (gros bouffon)."
    else
      puts "#{name} à encore #{life_points} point(s) de vie et une arme de niveau #{weapon_level}."
    end
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end


end


