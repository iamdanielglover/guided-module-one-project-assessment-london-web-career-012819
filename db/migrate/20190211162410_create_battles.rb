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

# class CreateBattles < ActiveRecord::Migration[5.2]
#   def change
#     create_table :battles do |t|
#       t.integer :trainer_id
#       t.integer :pokemon_id
#       t.integer :money
#       t.integer :round_count
#     end
#   end
# end
