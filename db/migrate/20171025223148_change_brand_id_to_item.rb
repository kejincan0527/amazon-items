class ChangeBrandIdToItem < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :brand_id, :integer, null: false
  end
end
