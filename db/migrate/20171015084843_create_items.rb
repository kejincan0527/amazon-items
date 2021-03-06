class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :asin, null: false
      t.text :title
      t.text :description
      t.integer :price
      t.text :amazon_url
      t.belongs_to :brand, foreign_key: true
      t.string :group
      t.text :main_image
      t.integer :stocks
      t.integer :active

      t.timestamps
    end
    add_index :items, :asin, :unique => true, :name => 'items_uniq_index'
  end
end
