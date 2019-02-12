class Battle < ActiveRecord::Base
  belongs_to :pokemon
  belongs_to :trainer

  def get_trainer_instance
    Trainer.find_by(id: self.trainer_id)
  end

  def trainer_name
    self.name
  end

  def trainers_pokemon_name
    self.pokemon.name
  end

  def make_attack
    damage_total = self.trainer.pokemon.attack + rand(1..30) - self.pokemon.defense
    self.pokemon.hp -= damage_total
    "#{self.trainer.pokemon.name} hit for #{damage_total}. Now, #{self.pokemon.name}'s health is reduced to #{self.pokemon.hp}"
  end

  def take_damage

  end

  def health

  end

end
