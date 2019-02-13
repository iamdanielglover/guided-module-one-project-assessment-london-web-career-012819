class Game

  attr_reader :trainer, :enemy

  def initialize
    @trainer = nil
    @enemy = nil
    start
  end

  def welcome
    puts " "
    puts " "
    puts " "
    puts " "
    puts " "
    puts " "
    puts "            W E L C O M E  T O "
    sleep 3
    system "clear"
    puts " "
    puts " "
    puts " "
    puts " "
    puts " "
    puts " "
    puts "            T H E  P O K E M O N - B A T T L E - S I M U L A T O R "

    sleep 3
    system "clear"
    puts " "
    puts " "
    puts " "
    puts " "
    puts " "
    puts " "
    puts "            Please enter your name: "
  end

  def get_user_name
    input = gets.chomp.capitalize
    @trainer = Trainer.find_or_create_by(name: input)
    puts "  ..."
    system "clear"
    sleep 0.5
    puts "Welcome #{input}!"
    sleep 2
  end

  def start
    system "clear"
    welcome
    get_user_name
    get_pokemon_name
    ready_to_fight?
    create_enemy
    system "clear"
    fighting_sequence
    sleep 4

    # puts "                         type exit"
    # gets.chomp
  end

  def fighting_sequence
    battle_platform
    get_attack
    continue?
    winner_or_loser?
  end

  def winner_or_loser?
    if @enemy.hp <= 0
      system "clear"
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts "            Y O U  A R E  T H E  C H A M P I O N            "
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
    end
    if @trainer.pokemon.hp <= 0
      system "clear"
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts "            U N L U C K Y  C H A M P,  B E T T E R  L U C K  N E X T  T I M E            "
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
    end
  end


  def continue?
    until @trainer.pokemon.hp <= 0 || @enemy.hp <= 0
      battle_platform
      get_attack
    end
  end

  def get_pokemon_name
    system "clear"
    sleep 0.5
    puts " "
    puts " "
    puts " "
    puts " "
    puts " "
    puts " "
    puts "P l e a s e   s t a t e   w h i c h   f i r s t - g e n   p o k e m o n"
    puts "y o u ' d   l i k e   t o   b e   p a r t n e r e d   w i t h ..."
    pokemon_choice = gets.chomp.capitalize
    pokemon = Pokemon.find_by(name: pokemon_choice)

    while pokemon == nil
      get_pokemon_name
      return
    end

    @trainer.pokemon = pokemon

    system "clear"
    puts " "
    puts "  ...hmm, #{@trainer.pokemon.name}."
    sleep 2
    system "clear"

    puts "You know what #{@trainer.name}?!"
    puts "#{@trainer.pokemon.name} is a marvellous choice!"
    puts "You two will be an awesome team!"
    sleep 5
  end

  def ready_to_fight?
    system "clear"
    puts " "
    puts " "
    puts " "
    puts " "
    puts " "
    puts " "
    puts "R e a d y ?  h i t  y / n"
    if gets.chomp.downcase == "y"
      system "clear"
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts "3"
      sleep 1.3
      system "clear"
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts "2"
      sleep 1.3
      system "clear"
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts "1"
      sleep 1.3
      system "clear"
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts " "
      puts "Here we go #{@trainer.pokemon.name}, let's keep our eyes peeled."
      sleep 3
    else
      system "exit"
    end
  end

  def create_enemy
    @enemy = Pokemon.find_by(id: rand(1..Pokemon.all.length))
    system "clear"
    puts " "
    puts " "
    puts " "
    puts " "
    puts " "
    puts " "
    puts " What's that!? It's a wild #{@enemy.name}!!!"
    sleep 3
    system "clear"
    puts " "
    puts " "
    puts " "
    puts " "
    puts " "
    puts " "
    puts "P r e p a r e   T o   F i g h t!"
    sleep 2
  end


  def battle_platform
    system "clear"
    puts "E N E M Y - Wild Pokemon"
    puts "#{@enemy.name} HP:#{@enemy.hp}"
    puts "A T T A C K - #{@enemy.attack}"
    puts "D E F E N S E - #{@enemy.defense}"
    puts " "
    puts " "
    puts " "
    puts "press a - n o r m a l   a t t a c k"
    puts " "
    puts "press s - s p e c i a l   a t t a c k"
    puts " "
    puts "press d - d e f e n s e   i n c r e a s e"
    puts " "
    puts " "
    puts " "
    puts "T R A I N E R - #{@trainer.name}"
    puts "#{@trainer.pokemon.name}   HP:#{@trainer.pokemon.hp}"
    puts "A T T A C K - #{@trainer.pokemon.attack} "
    puts "D E F E N S E - #{@trainer.pokemon.defense} "
  end

  def get_attack
    input = gets.chomp

      if input == "a"
        move = (@trainer.pokemon.attack/3) + rand(20..70) - @enemy.defense/2
        retaliation = (enemy.attack/3) + rand(20..60) - @trainer.pokemon.defense/2
        if move > 0
          @enemy.hp -= move
        else
          move = 0
        end
        if retaliation > 0
          @trainer.pokemon.hp -= retaliation
        else
          retaliation = 0
        end
        system "clear"
        puts "#{@trainer.name}'s #{@trainer.pokemon.name} hit for #{move}."
        puts "#{@enemy.name} HP: #{@enemy.hp}"
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts "#{@enemy.name} hit for #{retaliation}."
        puts "#{@trainer.name}'s' #{@trainer.pokemon.name} HP: #{@trainer.pokemon.hp}"
        sleep 2.5
      end

      if input  == "s"
        move = (@trainer.pokemon.attack/3) + rand(20..50) - @enemy.defense/2
        @trainer.pokemon.hp += rand(5..35)
        retaliation = (enemy.attack/3) + rand(20..60) - @trainer.pokemon.defense/2
        if retaliation > 0
          @trainer.pokemon.hp -= retaliation
        else
          retaliation = 0
        end
        if move > 0
          @enemy.hp -= move
        else
          move = 0
        end
        system "clear"
        puts "#{@trainer.name}'s #{@trainer.pokemon.name} hit for #{move}."
        puts "#{@enemy.name} HP: #{@enemy.hp}"
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts "#{@enemy.name} hit for #{retaliation}."
        puts "#{@trainer.name}'s' #{@trainer.pokemon.name} HP: #{@trainer.pokemon.hp}"
        sleep 2.5
      end

      if input == "d"
        move = 0
        trainer.pokemon.defense += rand(5..20)
        retaliation = (enemy.attack/3) + rand(20..50) - @trainer.pokemon.defense/1.5
        if retaliation > 0
          @trainer.pokemon.hp -= retaliation
        else
          retaliation = 0
        end
        system "clear"
        puts "#{@trainer.name}'s #{@trainer.pokemon.name} hit for #{move}."
        puts "#{@enemy.name} HP: #{@enemy.hp}"
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts "#{@enemy.name} hit for #{retaliation}."
        puts "#{@trainer.name}'s' #{@trainer.pokemon.name} HP: #{@trainer.pokemon.hp}"
        sleep 4
      end
  end

end
