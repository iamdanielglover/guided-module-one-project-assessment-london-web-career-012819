class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :attack
      t.integer :defense
      t.integer :hp
    end
  end
end
