require_relative '../config/environment'
# require_relative "../lib/pokapi_communicator.rb"
require_relative "../lib/command_line_interface.rb"


prompt = TTY::Prompt.new
prompt.keypress("Press space or enter to continue", keys: [:space, :return])
Game.new
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
