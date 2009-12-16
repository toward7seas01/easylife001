class Remark < ActiveRecord::Base
  belongs_to :blog, :counter_cache => true
  belongs_to :user
  #  validates_length_of :content , :minimum => 5
  attr_accessor :blog_user_id
  attr_accessible :content

  def after_new(params, session)
    super
    special_assign(params)
  end

  def after_edit(params, session)
    special_assign(params)
  end

  def self_path
    @self_path ||= "/users/#{self.blog_user_id}/blogs/#{self.blog_id}"
  end

  def special_assign(params)
    self.blog_user_id = params[:user_id]
  end

end
