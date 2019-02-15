require_relative '../config/environment'
Pokemon.destroy_all
# Trainer.destroy_all
# Battle.destroy_all

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
