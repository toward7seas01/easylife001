
def cool(origa, changed)
  names = origa.map(&:name).sort
  result = changed.split(" ").sort
  names.should == result
end


假如 /^有一个博客$/ do
  @blog = Factory(:blog02)
end

假如 /^数据库中所有分类为(.*)$/ do |global|
  global.split(" ").each do |category|
    Category.create(:name => category)
  end
end

假如 /^这个博客所拥有的分类为(.*)$/ do |related|
  related.split(" ").each do |category|
    @blog.categories << Category.find_by_name(category)
  end
end

当 /^用户输入下面的(.*)$/ do |input|
  @blog.category_n = input
  @blog.save
end

那么 /^这个博客之后所拥有的分类为(.*)$/ do |related|
  cool(@blog.categories(true), related)
end

那么 /^提交后数据库中所有分类为(.*)$/ do |global|
  cool(Category.all, global)
end






