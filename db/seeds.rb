# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Brand.create([
  {:name => 'GUCCI'},
  {:name => 'LOUIS VUITTON'}
])

Item.create([

  {
    :asin => 'ASIN001', 
    :title => 'TITLE001',
    :description => '',
    :price => 2000,
    :amazon_url => 'https://www.amazon.co.jp/',
    :brand_id => 1,
    :group => 'GROUP001',
    :main_image => 'https://goo.gl/1fETBE',
    :stocks => 2,
    :active => 1
  },

  {
    :asin => 'ASIN002', 
    :title => 'TITLE002',
    :description => '',
    :price => 3000,
    :amazon_url => 'https://www.amazon.co.jp/',
    :brand_id => 2,
    :group => 'GROUP002',
    :main_image => 'https://goo.gl/t4jSdE',
    :stocks => 3,
    :active => 1
  },

  {
    :asin => 'ASIN003', 
    :title => 'TITLE003',
    :description => '',
    :price => 1000,
    :amazon_url => 'https://www.amazon.co.jp/',
    :brand_id => 1,
    :group => 'GROUP001',
    :main_image => 'https://goo.gl/gyZ2NQ',
    :stocks => 2,
    :active => 0
  }
])
