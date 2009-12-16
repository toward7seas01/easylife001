require "custom/image"

class ProfilesController < BlogLikeController
  include Custom::ImageN

  def new
    super
    @profile = Profile.find_by_user_id(session[:user_id])
  end

  add_methods(:conceal, :unconceal) do
    @profile = Profile.find(params[:id])
    @profile.send(__method__)
    reload_page
  end

end

