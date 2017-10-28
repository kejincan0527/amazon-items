namespace :data_migration_tasks do
  desc "Activate all items"
  task :activate_all_items => :environment do
    Item.all.each do |item|
      item.update(active: 1)
    end
  end

  desc "Set ec_site to all items"
  task :set_ec_site_to_all_items => :environment do
    Item.where("amazon_url like '%amazon%'").each do |item|
      item.update(ec_site: 'Amazon')
    end
    Item.where("amazon_url not like '%amazon%'").each do |item|
      item.update(ec_site: '楽天市場')
    end
  end
end
