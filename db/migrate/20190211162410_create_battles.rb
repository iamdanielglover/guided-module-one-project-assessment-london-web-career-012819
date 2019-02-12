class CreateBattles < ActiveRecord::Migration[5.2]
  def change
    create_table :battles do |t|
      t.integer :trainer_id
      t.integer :pokemon_id
      t.boolean :status
      t.integer :round_count
    end
  end
end
