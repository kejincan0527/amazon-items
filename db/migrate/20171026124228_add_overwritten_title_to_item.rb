class AddOverwrittenTitleToItem < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :overwritten_title, :text
  end
end
