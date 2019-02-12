require_relative '../config/environment'
# require_relative "../lib/pokapi_communicator.rb"
require_relative "../lib/command_line_interface.rb"

system "clear"
welcome
get_user_name
pokemon_choice = get_pokemon_name
ready_to_fight?(pokemon_choice)

# while true
#   character = get_character_from_user
#   if character == "exit"
#     puts " "
#     puts "...thanks"
#     puts "\nFor Nothing... Goodbye!"
#     break
#   end
#   show_character_movies(character)
# end
#
# puts "hello world"

binding.pry
