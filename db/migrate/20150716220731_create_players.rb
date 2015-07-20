class CreatePlayers < ActiveRecord::Migration
  def up
    create_table :players do |t|
      t.string :code
      t.string :name
      t.string :team
      t.string :postion
      t.string :value
      t.timestamps
    end
  end

  def down
    drop_table players
  end
end
