class Blog < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  with_options :dependent => :destroy do |blog|
    blog.has_many :categorizations
    blog.has_many :blog_votes
    blog.has_many :remarks
    blog.has_one :blog_track
  end
  has_many :categories, :through => :categorizations
  
  named_scope :popular, :joins => :blog_track, :order => "blog_tracks.view_times", :include => :user, :limit => 7, :conditions => {:conceal => false}
  named_scope :show_blogs_by_category, lambda {|category_name, limit| {:limit => limit, :joins => :categories, :conditions => ["categories.name regexp ?", category_name]}}

  attr_writer :category_n
  attr_accessible :title, :content, :category_n

  Perpage_for_cache = 10

  def before_create
    build_blog_track
  end
  
  def after_new(params, session)
    self.user_id = session[:user_id]
  end
 
  def category_n
    self.categories.map(&:name).join(" ")
  end

  def before_save
    # 博客原先的category
    legacy_category = self.categories.map(&:name)
    input_category = Blog.handle_input(@category_n)
    # 在输入中有，但是不在遗留category中的category，即，至少需要创建categorization的category
    new_category = input_category - legacy_category

    Category.create(Blog.fresh_category(new_category))
    # 现在，new_category代表了需要创建categorization的全部category，fresh_category中的category部分已经创建完了
    # 接下来，是对需要的全部categorization进行创建
    self.categorizations << Categorization.create(needed_categorization(new_category))

    # 接下来，是对在本次输入中不存在的category，但是属于遗留category的category的关系categorization，即对过时失效的categorization进行处理
    handle_invalidation_categorizations(legacy_category - input_category)
  end

  class << self
    def handle_input(input)
      return [] if input.nil?
      result = []
      input.each(" ") do |i|
        i.strip!
        next if i.blank?
        result << i
      end
      result.uniq
    end

    def show_all(params)
      user_id = params[:user_id] ? params[:user_id] : params[:id]
      paginate_all_by_user_id(user_id, :include => :blog_track, :order => "created_at desc", :page => params[:page], :per_page => Perpage_for_cache)
    end

  end

  private

  def handle_invalidation_categorizations(invalidation_category_name)
    unless new_record?
      sql = ["delete cn from categories c, categorizations cn, blogs b where c.name in (?) and c.id = cn.category_id and b.id = cn.blog_id and b.id = #{id}", invalidation_category_name]
      connection.delete(Blog.ok_sql(sql))
    end
  end

  def needed_categorization(new_category)
    sql = ["select id from categories where name in (?) ", new_category]
    needed_category = connection.select_values(Blog.ok_sql(sql))
    needed_category.map do |i| {:category_id => i, :user_id => self.user_id } end
  end

  # 需要在全局创建的category，即，需要创建catgory和categorization的category
  def self.fresh_category(new_category)
    sql = ["select c.name from categories c where c.name in (?)", new_category]
    existed_category = connection.select_values(Blog.ok_sql(sql))
    (new_category - existed_category).map do |i| {:name => i} end
  end

end

