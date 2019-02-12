def welcome
  puts "Who are you?!? What's your name?"
  sleep 1
  sleep 1
end

def get_user_name
  input = gets.chomp.capitalize
  puts "  ..."
  system "clear"
  sleep 0.5
  puts "Welcome #{input}!"
  sleep 2
  input
end

def get_pokemon_name
  system "clear"
  sleep 0.5
  puts "Please state which first generation pokemon"
  puts "you'd like to be partnered with..."
  puts "  ..."
  puts " "
  pokemon_choice = gets.chomp.capitalize
  if Pokemon.find_by(name: pokemon_choice)
    else
      puts "Please enter a valid pokemon"
      pokemon_choice = gets.chomp.capitalize
    end
  puts " "
  puts "  ...hmm, #{pokemon_choice}."
  sleep 1.5
  puts " "
  puts "Great, #{pokemon_choice} is a marvellous choice!"
  puts "You'll be an awesome team."
  sleep 5
  pokemon_choice
end

def ready_to_fight?(pokemon_choice)
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
    puts "Goooooo #{pokemon_choice}!"
  else
    system "exit"
  end
end
