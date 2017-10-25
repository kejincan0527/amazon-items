class AddEcSiteToItem < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :ec_site, :string
  end
end
