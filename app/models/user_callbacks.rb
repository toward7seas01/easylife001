module UserCallbacks

  def self.included(base)
    base.before_create :generate_active_code
    base.after_create :generate_result, :confirm_email, :generate_archive, :generate_profile
    base.after_destroy :handle_archive
  end

  private
  
  def confirm_email
    call_rake("send_email", :user_id => self.id)
  end

  def generate_result
    results.create(:follow_id => 1)
  end

  def generate_profile
    file = File.open("#{RAILS_ROOT}/public/images/user_logo.gif")
    profile = create_profile(:uploaded_data => file)
    file.close

    path = File.dirname(profile.public_filename)
    old_url = "public" + profile.public_filename
    new_url = "public" + path + "/user_logo_thumb.gif"
    File.rename(old_url, new_url)
  end

  def generate_archive
    Archive.create(self.id)
  end

  def handle_archive
    File.delete(Archive.generate_file_name(self.id))
  end

  def generate_active_code
    self.active_code = Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by {rand}.join)
  end

end