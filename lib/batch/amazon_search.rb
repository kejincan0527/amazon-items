require 'amazon/ecs'

class Batch::AmazonSearch
  def self.init
    Amazon::Ecs.configure do |options|
      options[:AWS_access_key_id] = ENV["AWS_ACCESS_KEY_ID"]
      options[:AWS_secret_key] = ENV["AWS_SECRET_ACCESS_KEY"]
      options[:associate_tag] = ENV["AWS_ASSOCIATE_TAG"]
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

  def self.remove_tags(s)
    if s == nil
      return nil
    end
    return s.gsub(/&lt;/, "<").gsub(/&gt;/, ">").gsub(/<[^>]+>/, '')
  end

  def self.execute_one(brand_id)
    Dotenv.overload
    puts "Execute: AmazonSearch.ExecuteOne"
    init()
    brand = Brand.find(brand_id)
    if brand == nil
      puts brand_id + " does not exist"
    else
      puts "Execute " + brand.name + " update"
      if update_one(brand)
        puts "Successfully executed " + brand.name
      else
        puts "Error at execution " + brand.name
      end
    end
  end

  def self.update_one(brand)
    begin
      res = search(brand.name)
    rescue Amazon::RequestError => ex
      puts 'Amazon::RequestError:: sleep 60 seconds.'
      sleep(60)
      begin
        res = search(brand.name)
      rescue Amazon::RequestError => ex2
        puts ex2.message
        puts 'Amazon::RequestError:: Break running.'
        return false
      end
    end
    res.items.each do |a_item|
      asin = a_item.get('ASIN')
      p_brand = a_item.get('ItemAttributes/Brand')
      if !p_brand.downcase.include?(brand.name.downcase)
        next
      end
      puts 'ASIN: ' + asin + ' is processing.'
      p_item = Item.find_by_asin(asin)
      if p_item.nil?
        Item.create(
          asin: asin,
          title: remove_tags(a_item.get('ItemAttributes/Title')),
          description: remove_tags(a_item.get('EditorialReviews/EditorialReview/Content')) || brand.name + " iPhoneケース",
          price: a_item.get('ItemAttributes/ListPrice/Amount') || a_item.get('OfferSummary/LowestNewPrice/Amount') || a_item.get('OfferSummary/LowestUsedPrice/Amount'),
          amazon_url: a_item.get('DetailPageURL'),
          brand: brand,
          group: p_brand,
          ec_site: 'Amazon',
          main_image: a_item.get('LargeImage/URL'),
          stocks: a_item.get('OfferSummary/TotalNew'),
          active: 0
        )
      else
        puts 'ASIN: ' + asin + ' has already existed.'
        # TODO: update item
      end
    end
    return true
  end

  def self.execute_all
    Dotenv.overload
    puts "Execute: AmazonSearch.run"
    init()
    wait_seconds = 0
    Brand.all.each do |brand|
      sleep(wait_seconds)
      puts '== Brand: ' + brand.name + '=='
      if !update_one(brand)
        break
      end
      wait_seconds = 30
    end
  end

end
