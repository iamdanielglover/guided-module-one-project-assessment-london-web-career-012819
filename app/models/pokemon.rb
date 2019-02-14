class Pokemon < ActiveRecord::Base
  has_many :battles
  has_one :trainer, through: :battles

  def self.highest_attack
      Pokemon.all.max_by { |poke| poke.attack }
  end

  def self.lowest_attack
    Pokemon.all.min_by { |poke| poke.attack }
  end

end
