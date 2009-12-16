User.class_eval do
  def confirm_email
  end
end

ActiveRecord::Base.class_eval do
  class << self
    def attr_accessible(*attributes)
    end

    def attr_protected(*attributes)
    end
  end

end


file = File.open("/root/work/knight/public/images/user_logo.gif")
profile = Profile.create(:uploaded_data => file)
file.close

path = File.dirname(profile.public_filename)
old_url = "public" + profile.public_filename
new_url = "public" + path + "/user_logo_thumb.gif"
File.rename(old_url, new_url)

User.create!(:name => 'toward7seas', :email => 'toward7seas@126.com', :password => 'tttttt' )
User.create!(:name => 'easylife', :email => 'toward7seas@gmail.com', :password => 'tttttt' )
User.update_all("active_code = null")

Cover.create(:title => "cool", :user_id => 1)
Blog.create!(:title => "Ubuntu 10.10又出Web倒计时", :content => "Ubuntu从8.04就开始有这个WEB倒数计时器的了，日子过的真快，记得刚刚装Ubuntu时是在2007暑期，版本是7.04，还记得Canonical公司发言人Jane Silber说：“实际上，采用Ubuntu的这一新版本，对于脱离（move away）私有软件平台将比以往更加容易”。后来还申请了Ubuntu免费光盘，到现在已经9.10正式版也快发布乐，不知道再过两年，会是什么样子呢？如果你有兴趣，大家可以从getubuntu获取Ubuntu 9.10的WEB倒计时代码贴到自己的博客上。帮助传播Ubuntu的理念是向所有人开放的。包括：1. 星星 countdown 1；2. 聚光灯式的countdown 2；3. 不能使用JavaScript的countdown 3。", :user_id => 1)
Blog.create!(:title => "最早的高清电视机", :content => "宝龙拍卖行拍卖了Michael Bennett-Levy收藏的早期技术古董。 他的藏品中颇为引人注目的是Teleavia type P111，是法国Citroën DS公司于1958年生产的一台十分少见电视机，属于最早的高清电视机之一。电视机的显示屏为19英寸，显示能力为440线，而最高分辨率达到了819 线，超过720p，即使从今天的标准看，也属于高清了。P111只有原型，并没有真正上市销售。这台电视机的拍卖成交价为2400英镑。", :user_id => 2)

Forum.create(:title => "生活", :info => "enjoy it")
Forum.create(:title => "Ruby", :info => "enjoy it")
Forum.create(:title => "Rails", :info => "enjoy it")
Forum.create(:title => "jQuery", :info => "enjoy it")

content = "全世界的《星球大战》粉丝正在用一种新奇的方式去重新制作电影《星球大战：新希望》。 Star Wars：Uncut将原版电影以15秒的时间段分割，粉丝们可以注册认领一个15秒片段，然后对其进行重制，可以和朋友一起、按照自己想要的任何方式去完成，最后再上传到网站。目前《星球大战未删剪版》已经完成56%的进度，网站首页提供了所有已完成视频。当所有片段完成之后，将组合成一部原力四溢的神奇电影。预告片(所有视频都发布在Vimeo.com)。 "
params = {:topic => {:title => "星球粉丝集体制作《星球大战未删剪版》 ", :user_id => 1, :forum_id => 1, :comments_attributes =>[ {:content => content, :user_id => 1, :forum_id => 1}]}}
Topic.create(params[:topic])

content = "Techcrunch报道，土耳其政府在经过一年多的调查后，指控Google偷税，要求它缴纳3200万欧元（约人民币3.22亿）罚款。 当地媒体报道，土耳其政府声称它有征收附加税的权力，因为Google是在该国境内运营在线广告，而且在该国也有办公室和子公司。搜索巨人的欧洲总部位于爱尔兰首都，欧洲的支持服务和财政服务都集中在此，土耳其子公司的账单和付款都由欧洲总部统一管理。但土耳其政府认为，Google需为其基于土耳其的子公司产生的利润支付国家税，并声称审计显示这家美国公司未支付的税高达5100万欧元。Google反驳称，在线广告业务是由位于爱尔兰的欧洲分公司运营，它不需要因为在土耳其有子公司而缴税。Google称它遵守各个国家的税收法律，表示正就此问题与土耳其政府进行谈判。土耳其目前仍然封锁 YouTube网站。"
params = {:topic => {:title => "土耳其政府称Google欠交3200万税", :user_id => 1, :forum_id => 1, :comments_attributes => [{:content => content, :user_id => 1, :forum_id => 1}]}}
Topic.create(params[:topic])

content = "COMSHARP CMS 写道 jQuery Tools 是一套非常优秀的 Web UI 库，包括 Tab 容器，可折叠容器，工具提示，浮动层以及可滚动容器等等，可以为你的站点带来非同寻常的桌面般体验，这套工具的主要作用是显示内容，这是绝多多数站点最需要的东西。这套令人惊异的 UI 库只有 5.59K 大小，基于 MIT 和 GPL 两种许可模式(原始图文版)。"
params = {:topic => {:title => "jQuery Tools：我们期待已久的内容展示 ", :user_id => 1, :forum_id => 4, :comments_attributes => [{:content => content, :user_id => 1, :forum_id => 4}]}}
Topic.create(params[:topic])

content = "<a href='http://yehudakatz.com/2009/11/15/metaprogramming-in-ruby-its-all-about-the-self/'>http://yehudakatz.com/2009/11/15/metaprogramming-in-ruby-its-all-about-the-self/</a>"
params = {:topic => {:title => "self in Ruby", :user_id => 1, :forum_id => 2, :comments_attributes => [{:content => content, :user_id => 1, :forum_id => 2}]}}
Topic.create(params[:topic])

content = "<a href='http://www.slideshare.net/ihower/rails-best-practices'>http://www.slideshare.net/ihower/rails-best-practices</a>"
params = {:topic => {:title => "Rails Best Practices", :user_id => 1, :forum_id => 3, :comments_attributes => [{:content => content, :user_id => 1, :forum_id => 3}]}}
Topic.create(params[:topic])



Admin.create!(:area => 'admins', :user_id => 1)
Msg.create!(:content => "欢迎来到我的小站", :user_id => 1)
Msg.create!(:content => "enjoy it", :user_id => 1)

