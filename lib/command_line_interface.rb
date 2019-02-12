class Game

  attr_reader :trainer, :enemy

  def initialize
    @trainer = nil
    @enemy = nil
    start
  end

  def welcome
    puts "Who are you?!? What's your name?"
    sleep 2
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
    gets.chomp
    binding.pry
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
    puts "Please state which first generation pokemon"
    puts "you'd like to be partnered with..."
    puts " "
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
    sleep 1.5
    puts " "
    puts "Great, #{@trainer.pokemon.name} is a marvellous choice!"
    puts "You'll be an awesome team."
    sleep 5
  end

  def ready_to_fight?
    system "clear"

    puts "Ready?"
    puts "    y/n"
    if gets.chomp.downcase == "y"
      puts "...3"
      sleep 1.5
      puts "..2"
      sleep 1.5
      puts ".1"
      sleep 1.5
      puts " "
      puts "Here we go #{@trainer.pokemon.name}, let's keep our eyes peeled."
      sleep 2
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
    puts " What's that!? It's a wild #{@enemy.name}!!!"
    sleep 3
    puts " "
    puts " "
    puts " "
    puts "Prepare to fight!"
    sleep 2
  end


  def battle_platform
    system "clear"
    puts "E N E M Y - Wild Pokemon"
    puts "#{@enemy.name} HP:#{@enemy.hp}"
    puts " "
    puts " "
    puts " "
    puts " "
    puts "press a - normal attack"
    puts " "
    puts "press s - special attack"
    puts " "
    puts "press d - defense increase"
    puts " "
    puts " "
    puts " "
    puts " "
    puts "T R A I N E R - #{@trainer.name}"
    puts "#{@trainer.pokemon.name} HP:#{@trainer.pokemon.hp}"
  end

  def get_attack
    input = gets.chomp

      if input == "a"
        move = (@trainer.pokemon.attack/2) + rand(20..60) - @enemy.defense
        retaliation = (enemy.attack/2) + rand(20..50) - @trainer.pokemon.defense
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
        sleep 5
      end

      if input  == "s"
        move = (@trainer.pokemon.attack/2) + rand(20..40) - @enemy.defense
        @trainer.pokemon.hp += rand(5..10)
        retaliation = (enemy.attack/2) + rand(20..50) - @trainer.pokemon.defense
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
        sleep 5
      end

      if input == "d"
        move = 0
        trainer.pokemon.defense += rand(1..6)
        retaliation = (enemy.attack/2) + rand(20..50) - @trainer.pokemon.defense
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
        sleep 5
      end
  end

end
