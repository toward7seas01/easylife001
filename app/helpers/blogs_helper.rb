module BlogsHelper

  def replace_votes_size(vote_kind, votes_size)
    page.replace_html vote_kind_identifier(vote_kind), votes_size
  end

  def remark_class_name(user, auth)
    if user == auth
      c(user)
    else
      c(user) + " #{user_identifier(auth)}"
    end
  end

  private
  
  def vote_kind_identifier(kind)
    "vote_" << (kind == 1 ? 'up' : 'down')
  end


end
