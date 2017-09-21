desc "Scrape posts from xem.vn"

task :scrape_posts => :environment do

  require 'nokogiri'
  require 'open-uri'

  url = "http://xem.vn"

  html = Nokogiri::HTML(open(url))

  posts_xpath = "//div[@class='photoListItem']//div[@class='thumbnail']//a//img"

  posts = html.xpath(posts_xpath)

  posts.each do |post|

    title = post['alt']
    img_url = URI.parse(post['src'])
    category_id = rand(1..4)
    user = User.find_by(name: "canloi_bot")

    post = Post.new(title: title, user_id: user.id, category_id: category_id, picture: img_url)

    post.save!
  end
end
