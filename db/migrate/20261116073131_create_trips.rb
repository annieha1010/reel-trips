class CreateTrips < ActiveRecord::Migration[8.1]
  def change
    create_table :trips do |t|
      t.string :location
      t.date :date
      t.text :plan

      t.timestamps
    end
  end
end
