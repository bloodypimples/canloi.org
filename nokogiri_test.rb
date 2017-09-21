require 'nokogiri'
require 'open-uri'

url = "http://xem.vn"

html = Nokogiri::HTML(open(url))

posts_xpath = "//div[@class='photoListItem']//div[@class='thumbnail']//a//img"

posts = html.xpath(posts_xpath)

posts.each do |post|
  title = post['alt']
  img_url = post['src']
  img = open("https://i-xem.mkocdn.com/i.xem.sb/data/photo/2017/09/20/006/no-money-no-love-1505870706-400.jpg")
end
