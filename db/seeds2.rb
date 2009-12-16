require 'nokogiri'
require 'open-uri'


ActiveRecord::Base.class_eval do
  class << self
    def attr_accessible(*attributes)
    end

    def attr_protected(*attributes)
    end
  end

end

doc = Nokogiri::HTML(open('http://solidot.org'))

titles = doc.css('.generaltitle .title').map do |link| link.content.strip end
contents = doc.css('.intro').map do |link| link.content.strip end
blogs = titles.zip contents

generates = blogs.map do |i|
  {:title => i[0], :content => i[1], :user_id => 1}
end


blogs = Blog.create(generates)

urls = doc.css('li.more a').map do |i| "http:" + i.attribute('href').to_s end

remarks = urls.map do |url|
  art = Nokogiri::HTML(open(url))
  art.css('.commentBody div').map do |i| i.content end
end


remarks.map! do |remark|
  remark.map do |i|
    {:user_id => 1, :content => i}
  end
end


blogs.each_with_index do |blog, index|
  blog.category_n = "生活"
  blog.remarks = Remark.create(remarks[index])
  blog.save
  Blog.update_counters blog.id, :remarks_count => remarks[index].size  
end



