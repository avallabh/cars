class AddCarsTable < ActiveRecord::Migration
  def change
    create_table :cars do |x|
      x.string :color,      null: false
      x.integer :year,      null: false
      x.integer :mileage,   null: false
      x.string :description

      x.timestamps
    end
  end
end
