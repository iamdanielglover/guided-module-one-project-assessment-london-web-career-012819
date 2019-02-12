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
    @trainer = Trainer.create(name: input)
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
      puts "Goooooo #{@trainer.pokemon.name}!"
    else
      system "exit"
    end
  end

  def 

  def battle_platform
    puts "E N E M Y"
    puts ""
  end


end
