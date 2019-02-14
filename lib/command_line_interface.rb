class Game

  attr_reader :trainer, :enemy

  # @audio_files = {
  #   opening: "./audio/opening.mp3"
  # }
  #
  # def play_sound(key)
  #   require "audio-playback"
  #
  #   # Prompt the user to select an audio output
  #   @output = AudioPlayback::Device::Output.gets
  #
  #   options = {
  #     :channels => [0,1],
  #     :latency => 1,
  #     :output_device => @output
  #   }
  #
  #   @playback = AudioPlayback.play(@audio_files[key], options)
  # end

  def initialize
    @trainer = nil
    @enemy = nil
    @prompt = TTY::Prompt.new
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

  def welcome
    centered_text "W E L C O M E  T O "
    sleep 3
    system "clear"
    centered_text "T H E  P O K E M O N - B A T T L E - S I M U L A T O R "

    sleep 3
    system "clear"
  end

  def get_user_name
    centered_text "W h a t   i s   y o u r   n a m e ?"
    input = @prompt.ask('> ').capitalize
    @trainer = Trainer.find_or_create_by(name: input)
    puts "  ..."
    system "clear"
    sleep 0.5
    centered_text "Welcome #{input}!"
    sleep 2
  end

  def start
    # play_sound
    system "clear"
    centered_text "P r e s s   e n t e r   t o   c o n t in u e"
    @prompt.keypress("> ", keys: [:return])
    system "clear"
    welcome
    get_user_name
    get_pokemon_name
    # ready_to_fight?
    # create_enemy
    # system "clear"
    # fighting_sequence
    fight_segment

    sleep 4
  end

  def fight_segment
    ready_to_fight?
    create_enemy
    system "clear"
    fighting_sequence
  end

  def fighting_sequence
    # battle_platform
    battle_display
    get_attack
    continue?
    winner_or_loser?
  end
#
  def winner_or_loser?
    if @enemy.hp <= 0
      system "clear"
      centered_text "Y O U  A R E  T H E  C H A M P I O N"
      fight_segment
    end
    if @trainer.pokemon.hp <= 0
      system "clear"
      centered_text "U N L U C K Y  C H A M P,  B E T T E R  L U C K  N E X T  T I M E"
    end
  end


  def continue?
    until @trainer.pokemon.hp <= 0 || @enemy.hp <= 0
      battle_display
      get_attackdan

    end
  end

  def get_pokemon_name
    system "clear"
    sleep 0.5
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
    centered_text "You two will be an awesome team!"
    sleep 3
  end

  def ready_to_fight?
    system "clear"
    centered_text "W h e n   y o u ' r e   r e a d y   p r e s s   e n t e r"
    @prompt.keypress("> ", keys: [:return])
      system "clear"
      centered_text "3"
      sleep 1.3
      system "clear"
      centered_text "2"
      sleep 1.3
      system "clear"
      centered_text "1"
      sleep 1.3
      system "clear"
      centered_text "Here we go #{@trainer.pokemon.name}, let's keep our eyes peeled."
      sleep 3
  end

  def create_enemy
    @enemy = Pokemon.find_by(id: rand(1..Pokemon.all.length))
    system "clear"
    centered_text " What's that!? It's a wild #{@enemy.name}!!!"
    sleep 3
    system "clear"
    centered_text "P r e p a r e   T o   F i g h t!"
    sleep 2
  end


  def get_attack
    move_arr = ["n o r m a l   a t t a c k", "s p e c i a l   a t t a c k", "d e f e n s e   i n c r e a s e"]
    input = @prompt.select("c h o o s e   a   m a n e u v r e", move_arr, filter: true)
      if input == move_arr[0]
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
        pad_half_screen
        puts "#{@trainer.name}'s #{@trainer.pokemon.name} hit for #{move}."
        puts "#{@enemy.name} HP: #{@enemy.hp}"
        insert_spaces(2)
        puts "#{@enemy.name} hit for #{retaliation}."
        puts "#{@trainer.name}'s' #{@trainer.pokemon.name} HP: #{@trainer.pokemon.hp}"
        sleep 4
      end

      if input == move_arr[1]
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
        pad_half_screen
        puts "#{@trainer.name}'s #{@trainer.pokemon.name} hit for #{move}."
        puts "#{@enemy.name} HP: #{@enemy.hp}"
        insert_spaces(2)
        puts "#{@enemy.name} hit for #{retaliation}."
        puts "#{@trainer.name}'s' #{@trainer.pokemon.name} HP: #{@trainer.pokemon.hp}"
        sleep 4
      end

      if input == move_arr[2]
        move = 0
        trainer.pokemon.defense += rand(5..20)
        retaliation = (enemy.attack/3) + rand(20..50) - @trainer.pokemon.defense/1.5
        if retaliation > 0
          @trainer.pokemon.hp -= retaliation.round
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
        sleep 4
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
    # move_arr = ["n o r m a l   a t t a c k", "s p e c i a l   a t t a c k", "d e f e n s e   i n c r e a s e"]
    # @prompt.select("c h o o s e   a   m a n e u v r e", move_arr, filter: true)
  end
end
