class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :category
      t.string :website
      t.string :address
      t.string :location
      t.string :city
      t.string :state
      t.integer :zip
      t.string :borough

      t.timestamps
    end
  end
end
