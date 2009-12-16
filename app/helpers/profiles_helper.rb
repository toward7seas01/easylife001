module ProfilesHelper
  
  def user_profile(user)
    if user.profile.show?
      link_to thumb_image(user.profile), user
    else
      link_to thumb_image(alternate_profile), user
    end
  end

  def alternate_profile
    Profile::Alternate
  end


end
