class UsersController < BlogLikeController
  IndependentAction = [:new, :create, :activation, :destroy]
  skip_filter :current_space, :authentic, :session_exist?, :only => IndependentAction
  layout :decide

  before_filter :generate_model, :only => [:info, :edit]  
  caches_page :show
  
  def show
    @blogs = Blog.show_all(params)
  end

  def new
    @user = User.new
    render_new_dialog
  end

  def create
    #        if simple_captcha_valid?
    if true
      @user = User.new(params[:user])
      @user.name = params[:user][:name]

      if @user.save
        render_after_register
      else
        render "attributes_false.js"
      end
    else
      render "image_false.js"
    end
  end

  def update
    super do |format|
      format.html { redirect_to(info_user_path(@user.id)) }
    end
  end
  
  def activation
    if user = User.find_by_active_code(params[:num])
      user.update_attribute(:active_code, nil)
      assign_user_session(user)
      redirect_to user
    else
      render :text => "<div><h2>激活码无效，请仔细检查</h2></div>"
    end
  end

  def destroy
    super do |format|
      format.html { redirect_to home_url }
    end
  end

  private

  def decide
    (IndependentAction.include? action_name) ? "images" : "users"
  end

end

