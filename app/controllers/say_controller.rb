class SayController < ApplicationController
  skip_filter :master?

  def p_blogs
    @blogs = Blog.popular
    render @blogs
  end
  
  def p_topics
    @comments = Comment.p_topics
    render @comments
  end

  def p_bloggers
    @users = User.p_bloggers
    render @users
  end


end

