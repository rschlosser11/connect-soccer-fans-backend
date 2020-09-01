class CreateFixtures < ActiveRecord::Migration[6.0]
  def change
    create_table :fixtures do |t|
      t.integer :fixture_id
      t.datetime :event_date
      t.string :statusShort
      t.integer :elapsed
      t.string :venue
      t.string :referee
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :goalsHomeTeam
      t.integer :goalsAwayTeam

      t.timestamps
    end
  end
end
