class Game

  attr_reader :trainer, :enemy, :rounds

  def initialize
    @trainer = nil
    @enemy = nil
    @prompt = TTY::Prompt.new
    @rounds = 1

    start
  end

  def insert_spaces(n)
    n.times { puts " \n" }
  end

  def pad_half_screen
    spaces = IO.console.winsize[0] / 2
    insert_spaces(spaces)
  end

  def centered_text(text)
    width = IO.console.winsize[1] / 2
    pad_half_screen
    puts "#{" " * (width - (text.length / 2))}#{text}"
    pad_half_screen
  end

  def prompt_enter
    centered_text "P r e s s   e n t e r   t o   c o n t i n u e"
    @prompt.keypress("> ", keys: [:return])
    system "clear"
  end

  def start
    # play_sound
    system "clear"
    prompt_enter
    welcome
    get_user_name
    get_pokemon_name
    fight_segment
    Battle.create(trainer_id: self.trainer.id, pokemon_id: self.trainer.pokemon.id, round_count: self.rounds)
    score_table
  end

  def fight_segment
    display_round
    ready_to_fight?
    create_enemy
    system "clear"
    fighting_sequence
  end

  def fighting_sequence
    battle_display
    get_attack
    continue?
    winner_or_loser?
  end

  def welcome
    centered_text "W E L C O M E   T O "
    sleep 2
    system "clear"
    centered_text "T H E   P O K E M O N - B A T T L E - S I M U L A T O R "
    sleep 2
    system "clear"
  end

  def get_user_name
    centered_text "W h a t   i s   y o u r   n a m e ?"
    input = @prompt.ask('> ', required: true).capitalize
    stylized_input = input.split("").join(" ")
    @trainer = Trainer.find_or_create_by(name: input)
    puts "  ..."
    system "clear"
    sleep 0.5
    centered_text "W e l c o m e   #{stylized_input}!"
    sleep 2
  end

  def winner_or_loser?
    if @enemy.hp <= 0 && @trainer.pokemon.hp > 0
      system "clear"
      centered_text "N I C E  O N E  C H A M P !"
      sleep 2
      @rounds += 1
      fight_segment
    end
    if @trainer.pokemon.hp <= 0
      system "clear"
      centered_text "T H A T  W A S N ' T  A  B A D  R U N  A T  A L L!"
      sleep 2
      system "clear"
    end
  end

  def display_round
      centered_text "R O U N D  #{@rounds}"
      sleep 2
  end


  def continue?
    until @trainer.pokemon.hp <= 0 || @enemy.hp <= 0
      battle_display
      get_attack
    end
  end

  def get_pokemon_name
    system "clear"
    pokelist = Pokemon.all.map {|poke| poke.name}
    centered_text "C h o o s e   y o u r   p o k e m o n"
    pokemon_choice = @prompt.select("> ", pokelist, filter: true)
    pokemon = Pokemon.find_by(name: pokemon_choice)
    @trainer.pokemon = pokemon
    system "clear"
    centered_text "  ...hmm, #{@trainer.pokemon.name}."
    sleep 2
    system "clear"
    centered_text "You know what #{@trainer.name}?!"
    sleep 2
    system "clear"
    centered_text "#{@trainer.pokemon.name} is a marvellous choice!"
    sleep 2
    system "clear"
    centered_text "The two of you will be an awesome team!"
    sleep 2
    centered_text "Here we go #{@trainer.pokemon.name}, let's keep our eyes peeled."
    sleep 2
  end

  def ready_to_fight?
    system "clear"
    centered_text "W h e n   y o u ' r e   r e a d y   p r e s s   e n t e r"
    @prompt.keypress("> ", keys: [:return])
      system "clear"
      centered_text "3"
      sleep 1
      system "clear"
      centered_text "2"
      sleep 1
      system "clear"
      centered_text "1"
      sleep 1
      system "clear"
  end

  def create_enemy
    @enemy = Pokemon.find_by(id: rand(1..Pokemon.all.length))
    name = @enemy.name
    system "clear"
    centered_text "I t ' s   a   w i l d   #{name.split("").join(" ")} ! ! !"
    sleep 2
    system "clear"
    centered_text "P r e p a r e   T o   F i g h t!"
    sleep 2
  end


  def get_attack
    move_arr = ["f u l l   a t t a c k", "h e a l   a t t a c k", "d e f e n s e   i n c r e a s e"]
    input = @prompt.select("c h o o s e   a   m a n e u v r e", move_arr, filter: true)
      if input == move_arr[0]
        move = (@trainer.pokemon.attack/10) + rand(5..25) - @enemy.defense/9
        retaliation = (enemy.attack/10) + rand(5..25) - @trainer.pokemon.defense/9
        if move > 0
          @enemy.hp -= move
          if @enemy.hp < 0
            @enemy.hp = 0
          end
        else
          move = 0
        end
        if retaliation > 0
          @trainer.pokemon.hp -= retaliation
          if @trainer.pokemon.hp < 0
            @trainer.pokemon.hp = 0
          end
        else
          retaliation = 0
        end
        system "clear"
        pad_half_screen
        puts "#{@trainer.name}'s #{@trainer.pokemon.name} hit for #{move}."
        puts "#{@enemy.name} HP: #{@enemy.hp}"
        insert_spaces(2)
        puts "#{@enemy.name} hit for #{retaliation}."
        puts "#{@trainer.name}'s' #{@trainer.pokemon.name} HP: #{@trainer.pokemon.hp}"
        sleep 3
      end

      if input == move_arr[1]
        move = (@trainer.pokemon.attack/10) + rand(1..20) - @enemy.defense/9
        @trainer.pokemon.hp += rand(5..15)
        retaliation = (enemy.attack/10) + rand(1..25) - @trainer.pokemon.defense/9
        if retaliation > 0
          @trainer.pokemon.hp -= retaliation
          if @trainer.pokemon.hp < 0
            @trainer.pokemon.hp = 0
          end
        else
          retaliation = 0
        end
        if move > 0
          @enemy.hp -= move
          if @enemy.hp < 0
            @enemy.hp = 0
          end
        else
          move = 0
        end
        system "clear"
        pad_half_screen
        puts "#{@trainer.name}'s #{@trainer.pokemon.name} hit for #{move}."
        puts "#{@enemy.name} HP: #{@enemy.hp}"
        insert_spaces(2)
        puts "#{@enemy.name} hit for #{retaliation}."
        puts "#{@trainer.name}'s' #{@trainer.pokemon.name} HP: #{@trainer.pokemon.hp}"
        sleep 3
      end

      if input == move_arr[2]
        move = 0
        trainer.pokemon.defense += rand(1..8)
        retaliation = ((enemy.attack/10) + rand(5..25) - @trainer.pokemon.defense/8).to_i
        if retaliation > 0
          @trainer.pokemon.hp -= retaliation.to_i
          if @trainer.pokemon.hp < 0
            @trainer.pokemon.hp = 0
          end
        else
          retaliation = 0
        end
        system "clear"
        pad_half_screen
        puts "#{@trainer.name}'s #{@trainer.pokemon.name} hit for #{move}."
        puts "#{@enemy.name} HP: #{@enemy.hp}"
        insert_spaces(2)
        puts "#{@enemy.name} hit for #{retaliation}."
        puts "#{@trainer.name}'s' #{@trainer.pokemon.name} HP: #{@trainer.pokemon.hp}"
        sleep 3
      end
  end

  def battle_display
    system "clear"
    pad_half_screen
    puts "E N E M Y - Wild Pokemon"
    puts "#{@enemy.name} HP:#{@enemy.hp}"
    puts "A T T A C K - #{@enemy.attack}"
    puts "D E F E N S E - #{@enemy.defense}"
    puts "----------------------------------"
    puts "T R A I N E R - #{@trainer.name}"
    puts "#{@trainer.pokemon.name}   HP:#{@trainer.pokemon.hp}"
    puts "A T T A C K - #{@trainer.pokemon.attack} "
    puts "D E F E N S E - #{@trainer.pokemon.defense} "
    puts "----------------------------------"
  end

  def score_table
    rows = []
    sorted_battles = Battle.all.sort_by { |bat| bat.round_count  }.reverse
      sorted_battles.each do |bat|
        rows << [ bat.trainer.name, bat.pokemon.name, bat.round_count ]
      end

    table = Terminal::Table.new :title => "Score Table", :headings => ['Trainer', 'Pokemon', 'Round'], :rows => rows
    puts table

    choices = ["Play again", "Quit"]
    input = @prompt.select("O P T I O N S", choices, filter: true)
      if input == choices[0]
        start
      end
      if input == choices[1]
        system 'exit'
      end
  end

end
