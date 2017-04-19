class UpdateColumnsInEvents < ActiveRecord::Migration[5.0]
  def change
    change_column :events, :borough, :text, array: true, default: [], using: "(string_to_array(borough, ','))"
  	change_column :events, :category, :text, array: true, default: [], using: "(string_to_array(category, ','))"
  end
end
