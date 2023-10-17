require 'pry'



class Player 
  attr_accessor :name, :life_points

  def initialize(name, life_points = 20)
    @name = name.to_s
    @life_points = life_points
  end



  def show_state 
    if @life_points <= 0
      puts "#{name} est DCD (gros bouffon)."
    else
      puts "#{name} à encore #{life_points} points de vie."
    end
  end



  def gets_damage(damage)
    if damage >= @life_points
      puts "Il prend #{damage} et... GAME OVER #{name} décède (gros bouffon)."
      @life_points = 0
    else  
      @life_points -= damage
      puts "#{name} perd #{damage} point(s) de vie. Il lui reste #{life_points} points de vie."
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




# --------------------------------------------------------------------------------




class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name, life_points = 30, weapon_level = 1)
    @weapon_level = weapon_level.to_i
    super(name, life_points)
  end


  def show_state 
    if @life_points <= 0
      puts "#{name} est DCD (gros bouffon)."
    else
      puts "#{name} à encore #{life_points} points de vie et une arme de niveau #{weapon_level}."
    end
  end


  def compute_damage
    rand(1..6) * @weapon_level
  end


  def search_weapon
    new_weapon_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon_level}."
    if new_weapon_level > @weapon_level
      @weapon_level = new_weapon_level
      puts "#{name} prend la nouvelle arme."
    else  
      puts "Ton arme de niveau #{weapon_level} est déjà meilleure. Tu veux quoi ?"
    end
  end


  def search_health_pack
    health_pack_rand = rand(1..6)
    case health_pack_rand
    when 1
      puts "Tu n'as rien trouvé, cherche encore."
    when 2..5
      if @life_points >= 25
        @life_points = 30
      else  
        @life_points = @life_points + 5
      end
      puts "+5 points de vie. Tu as maintenant #{life_points} points de vie."
    when 6 
      if @life_points >= 10
        @life_points = 30
      else  
        @life_points = @life_points + 20
      end
      puts "JACKPOT !!! +20 points de vie. Tu as maintenant #{life_points} points de vie."
    end


  end


end


