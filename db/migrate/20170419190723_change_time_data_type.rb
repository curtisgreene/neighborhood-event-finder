class ChangeTimeDataType < ActiveRecord::Migration[5.0]
  def change
    change_column :events, :start_time, :timestamptz
    change_column :events, :end_time, :timestamptz
  end
end
