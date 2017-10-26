class AddDescriptionToBrand < ActiveRecord::Migration[5.1]
  def change
    add_column :brands, :description, :text
  end
end
