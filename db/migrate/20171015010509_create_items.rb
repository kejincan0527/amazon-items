class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :asin
      t.text :title
      t.text :description
      t.integer :price
      t.text :amazon_url
      t.string :brand
      t.string :group
      t.text :main_image
      t.integer :stocks

      t.timestamps
    end
  end
end
