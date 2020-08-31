class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.integer :team_id
      t.string :name
      t.string :logo
      t.string :country
      t.integer :founded
      t.string :venue_name
      t.string :venue_city

      t.timestamps
    end
  end
end
