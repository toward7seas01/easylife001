class FeedsController < ApplicationController
  
  def index
    users = User.my_following(session[:user_id])
    @names = users.map do |i| [i.name, i.id] end
    how_is_following(users.map(&:id))
  end


  def show
    how_is_following(params[:id])
    respond_to do |format|
      format.html
      format.js { render :partial => "result", :object => @feeds }
    end   
  end

  def create
    follow_id = Result.generate_human_follow(session[:user_id], params[:name])
    redirect_to feed_path(follow_id)
  end

  def destroy
    Result.destroy(params[:id])
    redirect_to feeds_path
  end

  def favourite
    @humans = Result.human(session[:user_id])
    @autos = Result.auto(session[:user_id])
  end

  private

  def how_is_following(users)
    @feeds = Feed.how_is_following(users, params[:page])
  end

end
