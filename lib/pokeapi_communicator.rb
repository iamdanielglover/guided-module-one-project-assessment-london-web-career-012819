require 'rest-client'
require 'json'
require 'pry'

response_string  = RestClient.get('https://pokeapi.co/api/v2/pokemon/?offset=0&limit=100')
response_hash = JSON.parse(response_string)
