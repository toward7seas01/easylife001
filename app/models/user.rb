require 'digest/sha1'

class User < ActiveRecord::Base
  include UserCallbacks
  
  validates_presence_of :name
  validates_uniqueness_of :name, :message => "用户已存在"
  validates_uniqueness_of :email
  attr_accessor :password_confirmation
  validates_confirmation_of :password, :message => "密码输入不一致"
  validates_length_of :password, :minimum => 6, :allow_blank => true, :on => :update
  validates_length_of :password, :minimum => 6, :on => :create
  validates_format_of :email, :with => /\w+([-.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/, :message => "邮箱地址格式有误"

  with_options :dependent => :destroy  do |user|
    user.has_one :profile
    user.has_one :banner
    user.has_many :blogs
    user.has_many :categorizations
    user.has_many :blog_votes
    user.has_many :comments
    user.has_many :remarks
    user.has_many :covers
    user.has_many :images
    user.has_many :msgs
    user.has_many :results
  end

  has_many :topics
  has_many :followers, :through => :results
  has_many :categories, :through => :categorizations
  has_one :admin

  attr_reader :password
  accepts_nested_attributes_for :admin
  attr_accessible :admin_attributes, :name, :info, :from, :sex, :profession, :taste, :email, :password, :password_confirmation


  def password=(pwd)
    @password = pwd
    return if @password.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  def activated?
    active_code.nil?
  end

  def archive
    Archive.read(self.id)
  end

  def commute
    commute_with_archive
    commute_with_database
  end

  def format_errors
    expect_size = 4
    message = []
    message << errors[:name] << errors[:email]
    message.push(*errors[:password])
    message.push(*Array.new(expect_size - message.size))
  end

  class << self

    def find_admin(admin_id)
      first :joins => :admin, :conditions => {:admins => {:id => admin_id} }
    end

    def encrypted_password(password, salt)
      string_to_hash = password + "knight" + salt
      Digest::SHA1.hexdigest(string_to_hash)
    end

    def my_following(user_id)
      find_by_sql("select u.id, u.name from results r, users u where r.user_id = #{user_id} and r.follow_id = u.id order by r.weight desc")
    end

  end

  def self.p_bloggers
    public.find(:all, :include => :profile, :order => 'view_times desc', :limit => Limit)
  end

  private

  def commute_with_database
    new_results = self.archive.choose_result_by_limit
    Result.destroy_all("user_id = #{archive.id} and sort = 0")
    Result.create(new_results)
  end

  def commute_with_archive
    auto_follow = {}
    results.auto_follow.each do |i|
      auto_follow[i.follow_id] = i.weight
    end
    archive.auto_follow.merge! auto_follow
    archive.write
  end

end

