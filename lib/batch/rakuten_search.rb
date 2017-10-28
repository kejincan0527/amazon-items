require 'rakuten_web_service'

class Batch::RakutenSearch
  def self.execute_one(brand_id)
    Dotenv.overload
    puts "Execute: RakutenSearch.ExecuteOne"
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

  def self.execute_all
    Dotenv.overload
    puts "Execute: RakutenSearch.ExecuteAll"
    wait_seconds = 0
    Brand.all.each do |brand|
      sleep(wait_seconds)
      puts '== Brand: ' + brand.name + '=='
      if !update_one(brand)
        puts "[ERROR] with update one. SLEEP 60 seconds"
        sleep(60)
      end
      wait_seconds = 5
    end
  end

  def self.keyword_include?(s, search_keywords)
    search_keywords.split(" ").each do |kw|
      if !s.include?(kw)
        return false
      end
    end
    return true
  end

  def self.update_one(brand)
    begin
      search_keyword = brand.name.gsub(/ . /, ' ').gsub(/^. /, '').gsub(/ .$/, '')
      puts "SEARCH KEYWORD is : " + search_keyword
      r_items = RakutenWebService::Ichiba::Item.search(
        keyword: 'iphoneケース ' + search_keyword,
        imageFlag: 1
      )
      r_items.each do |r_item|
        r_asin = r_item.code
        if !keyword_include?(r_item.name.downcase, search_keyword.downcase)
          next
        end
        r_title = r_item.name
        r_description = r_item.caption
        r_price = r_item.price
        r_amazon_url = r_item.url
        r_group = r_item.shop_code
        r_main_image = r_item.medium_image_urls.first.gsub(/\?_ex=128x128$/, '').gsub(/http:/, 'https:')
        r_stocks = r_item.availability
        puts 'item.code: ' + r_asin + ' is processing.'
        p_item = Item.find_by_asin(r_asin)
        if p_item.nil?
          Item.create(
            asin: r_asin,
            title: r_title,
            description: r_description,
            price: r_price,
            amazon_url: r_amazon_url,
            brand: brand,
            ec_site: '楽天市場',
            group: r_group,
            main_image: r_main_image,
            stocks: r_stocks,
            active: 1
          )
        else
          puts 'ITEM.CODE: ' + r_asin + ' has already existed.'
          p_item.update(
            title: r_title,
            description: r_description,
            price: r_price,
            amazon_url: r_amazon_url,
            brand: brand,
            group: r_group,
            main_image: r_main_image,
            stocks: r_stocks
          )
        end
      end
      puts brand.name + " is successfully executed."
    rescue => ex
      puts ex.message
      puts "[ERROR] " + brand.name + " executed with error."
      return false
    end
    return true
  end
end
