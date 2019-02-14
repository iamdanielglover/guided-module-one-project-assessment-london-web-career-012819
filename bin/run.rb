require_relative '../config/environment'
# require_relative "../lib/pokapi_communicator.rb"
require_relative "../lib/command_line_interface.rb"

game = Game.new
Battle.create(trainer_id: game.trainer.id, pokemon_id: game.trainer.pokemon.id, pokemon_enemy: game.enemy.id)

t.integer :trainer_id
t.integer :pokemon_id
t.boolean :status
t.integer :round_count
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
