require 'custom/current'

module Custom
  module ImageN
    include Current

    def new
      @image = current_model.new
    end

    def create
      @image = current_model.new(params[current_sym])

      if user_save_with_image
        render "profiles/create"
      else
        render :action => "new"
      end
    end

    def update
      @image = current_model.find(params[:id])

      if @image.handle_profile(params[current_sym])
        redirect_to info_user_path(params[:user_id])
      else
        flash[:notice] = "请确定裁减尺寸"
        render "profiles/create"
      end
    end

    private

    def user_save_with_image
      User.find(session[:user_id]).send("#{@image.class_to_s}=", @image)
    end
    

  end
end
