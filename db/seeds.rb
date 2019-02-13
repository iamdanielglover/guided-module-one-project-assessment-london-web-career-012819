require_relative '../config/environment'
Pokemon.destroy_all
# Trainer.destroy_all
# Battle.destroy_all
#
# bulbasaur = Pokemon.create(name: "Bulbasaur", attack: 49, defense: 49, hp: 45)
# charmander = Pokemon.create(name: "Charmander", attack: 52, defense: 43, hp: 39)
# squirtle = Pokemon.create(name: "Squirtle", attack: 48, defense: 65, hp: 44)
# pikachu = Pokemon.create(name: "Pikachu", attack: 55, defense: 40, hp: 35)
# vulpix = Pokemon.create(name: "Vulpix", attack: 41, defense: 40, hp: 38)
# jigglypuff = Pokemon.create(name: "Jigglypuff", attack: 20, defense: 45, hp: 115)
#
# trainer1 = Trainer.create(name: "Gary", pokemon_id: 4)
# trainer2 = Trainer.create(name: "Ash", pokemon_id: 6)
#
# Battle.create(trainer_id: 1, pokemon_id: 1, status: true, round_count: 1)

require 'rest-client'
require 'json'
require 'pry'


def get_all_pokemon

  url = 'https://pokeapi.co/api/v2/pokemon/?offset=0&limit=151'

  response_string  = RestClient.get(url)
  api_hash = JSON.parse(response_string)

  api_hash["results"].map do |p|
    response = RestClient.get(p["url"])
    poke_hash = JSON.parse(response)
    poke_hash
  end
end

all_pokemon = get_all_pokemon

all_pokemon.each do |p|
  Pokemon.create(
    name: p["name"].capitalize,
    attack: p["stats"][4]["base_stat"],
    defense: p["stats"][3]["base_stat"],
    hp: p["stats"][5]["base_stat"]
  )



end
