class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :number
      t.string :position
      t.string :height
      t.string :weight
      t.date :birthdate
      t.string :nationality
      t.integer :team_id

      t.timestamps
    end
  end
end
