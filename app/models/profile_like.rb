require 'RMagick'

class ProfileLike < ActiveRecord::Base

  self.abstract_class = true
  belongs_to :user
  CropNeed = [:crop_x, :crop_y, :crop_w, :crop_h]
  attr_accessor(*CropNeed)

  add_methods(:width, :height) do
    "#{self.class}::#{__method__.to_s.capitalize}".constantize
  end
  
  def handle_profile(params)

    sets = CropNeed.map do |name|
      return false if params[name].empty?
      params[name].to_i
    end

    file_name = "public#{self.public_filename}"
    ext = File.extname(file_name)
    img = Magick::ImageList.new(file_name)
    img.crop(*sets).write(file_name.sub(ext, "_thumb#{ext}"))
  end



end
