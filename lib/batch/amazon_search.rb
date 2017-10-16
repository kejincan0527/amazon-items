require 'amazon/ecs'

class Batch::AmazonSearch
  def self.init
    Amazon::Ecs.configure do |options|
      options[:AWS_access_key_id] = Rails.application.secrets.amazon_ecs_access_key_id
      options[:AWS_secret_key] = Rails.application.secrets.amazon_ecs_secret_access_key
      options[:associate_tag] = Rails.application.secrets.amazon_ecs_associate_tag
    end
  end

  def self.search(brand)
    res = Amazon::Ecs.item_search(
      'iphoneケース', 
      {
        :response_group => 'Medium', 
        :search_index => 'Electronics', 
        :country => 'jp',
        :manufacturer => brand,
        :sort => '-releasedate'
      }
    )
    return res
  end

  def self.run
    puts "Execute: AmazonSearch.run"
    init()
    wait_seconds = 0
    Brand.all.each do |brand|
      sleep(wait_seconds)
      puts '== Brand: ' + brand.name + '=='
      begin
        res = search(brand.name)
      rescue Amazon::RequestError => ex
        puts 'Amazon::RequestError:: sleep 20 seconds.'
        sleep(20)
        begin
          res = search(brand.name)
        rescue Amazon::RequestError => ex2
          puts ex2.message
          puts 'Amazon::RequestError:: Break running.'
          break
        end
      end
      res.items.each do |a_item|
        asin = a_item.get('ASIN')
        puts 'ASIN: ' + asin + ' is processing.'
        p_item = Item.find_by_asin(asin)
        if p_item.nil?
          Item.create(
            asin: asin,
            title: a_item.get('ItemAttributes/Title'),
            brand: brand
          )
        else
          puts 'ASIN: ' + asin + ' has already existed.'
          # TODO: update item
        end
      end
      wait_seconds = 10
    end
  end
end
