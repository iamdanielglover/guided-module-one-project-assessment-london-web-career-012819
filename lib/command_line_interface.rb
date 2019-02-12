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
    input
  end

  def start
    system "clear"
    welcome
    get_user_name
    get_pokemon_name
    ready_to_fight?
    create_enemy
    system "clear"
    battle_platform
    attack
    battle_platform
    binding.pry
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

  def attack
    input = gets.chomp
      if input == "a"
        move = @trainer.pokemon.attack + rand(10..40) - @enemy.defense
        if move > 0
          @enemy.hp -= move
        end
      end
      if input  == "s"
        move = @trainer.pokemon.attack + rand(1..20) - @enemy.defense
        @trainer.pokemon.hp += rand(1..10)
        if move > 0
          @enemy.hp -= move
        end
      end
      if input == "d"
        trainer.pokemon.defense += rand(1..5)
      end
  end

end
