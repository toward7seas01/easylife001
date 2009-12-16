require 'custom/current'

class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  include SimpleCaptcha::ControllerHelpers
  include Custom::Current
  
  Perpage = 10
  Limit = 7

  uses_tiny_mce(:options => {
      :theme => 'advanced',
      :language => 'zh',
      :convert_urls => false,
      :theme_advanced_toolbar_location => "top",
      :theme_advanced_toolbar_align => "left",
      :theme_advanced_resizing => true,
      :theme_advanced_resize_horizontal => false,
      :paste_auto_cleanup_on_paste => true,
      :theme_advanced_buttons1 => %w{formatselect fontselect fontsizeselect forecolor backcolor bold italic underline strikethrough sub sup removeformat},
      :theme_advanced_buttons2 => %w{undo redo cut copy paste separator justifyleft justifycenter justifyright separator indent outdent separator bullist numlist separator link unlink image media emotions separator table separator fullscreen},
      :theme_advanced_buttons3 => [],
      :theme_advanced_fonts => %w{宋体=宋体;黑体=黑体;仿宋=仿宋;楷体=楷体;隶书=隶书;幼圆=幼圆;Andale Mono=andale mono,times;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;},
      :plugins => %w{contextmenu paste media emotions table fullscreen}},
    :only => [:new, :edit, :create, :update])

  before_filter :master?
  before_filter :handle_action, :only => [:conceal, :unconceal]
  before_filter :session_exist?, :only => [:new, :edit, :create, :update, :destroy]


  def index(&block)
    instance_variable_set(current_instances_sym, current_model.all)

    output_result(block)
  end

  def new(&block)
    instance_variable_set(current_instance_sym, current_model.new)

    output_new_or_edit(block)
  end

  def show(&block)
    generate_model

    output_result(block)
  end
  
  def edit(&block)
    generate_model

    output_new_or_edit(block)
  end

  def update
    instance_variable = generate_model
    instance_variable.after_edit(params, session)

    respond_to do |format|
      if instance_variable.update_attributes(params[current_sym])
        yield format if block_given?
        format.html {redirect_to instance_variable.that_path(request.path)}
      else
        render_if_exist_custom(format)
        format.html {render :action => "edit"}
      end
    end
  end

  def create
    instance_variable = instance_variable_set(current_instance_sym, current_model.new(params[current_sym]))
    instance_variable.after_new(params, session)

    respond_to do |format|
      if instance_variable.save
        yield format if block_given?
        format.html {redirect_to instance_variable.that_path( request.path + "/#{instance_variable.id}")}
      else
        render_if_exist_custom(format)
        format.html {render :action => "new"}
      end
    end
  end

  def destroy
    generate_model.destroy
    
    respond_to do |format|
      yield(format) if block_given?
      format.html { redirect_to generate_model.that_path( File.dirname(request.path)) }
    end
  end

  def conceal  
    render :update do |page|
      page.select(idf_class(generate_model)).add_class('conceal').html("已隐藏")
    end
  end

  def unconceal
    render :update do |page|
      page.select(idf_class(generate_model)).remove_class('conceal').html(nil)
    end
  end

  helper_method :a?, :show?, :u?, :u, :generate_model

  protected
  
  def rescue_action_in_public(e)
    false_page
  end

  def local_request?
    super
  end
  
  private

  def output_result(block)
    respond_to do |format|
      block.call(format) if block
      format.html
    end
  end

  def render_if_exist_custom(format)
    format.html {render_new_or_edit} if need_extra_render?
  end

  def output_new_or_edit(block)
    respond_to do |format|
      block.call(format) if block
      render_if_exist_custom(format)
      format.html
    end
  end
  
  def ownership?
    generate_model.user_id == session[:user_id]
  end

  def handle_action
    generate_model.send(:"a#{params[:action]}")
  end

  def is_self?(user, password)
    user and user.hashed_password == User.encrypted_password(password, user.salt)
  end

  def render_after_register
    render :update do |page|
      page.replace_html ".a_l_i", "<span>已向您的信箱发送激活邮件，请注意查收</span>"
      page.vanish
    end
  end

  def show?(model)
    model.show? or (model.user_id = session[:user_id] or a?)
  end

  def reload_page
    render :update do |page| page.reload end
  end

  def render_nothing
    render :nothing => true
  end

  def delete_dom
    render :update do |page|
      page.replace dom_id(generate_model)
    end
  end

  def false_page
    render :template => "#{RAILS_ROOT}/public/404.html", :layout => "error"
  end

  def assign_user_session(user)
    session[:user_id], session[:user_name] = user.id, h(user.name)
  end

  def assign_admin_session(admin)
    session[:a_area], session[:user_id], session[:user_name] = admin.area, admin.user_id, h(admin.name)
  end

  def redirect_from_admin_area
    redirect_to request.request_uri.sub("/admin", "")
  end

  def render_new_dialog
    render :update do |page|
      page.insert_html :bottom, "page", :partial => 'new'
      page.call('cancel')
    end
  end

  def need_preview?
    if params[:commit] == "预览"
      @preview = true
      if controller_name == "topics"
        @comment = @topic.comments.first
      else
        @topic = @comment.topic
      end
      render "comments/preview"
    end
  end

  def need_chomped_url
    case action_name
    when 'new', 'create'
      request.path.chomp("/new")
    else
      request.path.chomp("/edit")
    end
  end

  def need_extra_render?
    File.exist?("app/views/" + controller_name + "/_new_or_edit.html.erb")
  end

  def render_new_or_edit
    url = need_chomped_url
    render :partial => 'new_or_edit', :locals => {:url => url}, :layout => true
  end

  def master?
    if judge_admin_path?
      false_page unless master_area?
    elsif master_area?
      redirect_to "/admin#{request.request_uri}"
    end
  end

  def judge_path
    request.path =~ /admin\//
  end

  alias_method :j_a?, :judge_path
  alias_method :judge_admin_path?, :judge_path

  def master_area?
    @master ||= (session[:a_area] == "admins" or params[:controller].split("/")[-1] == session[:a_area])
  end

  alias_method :m_a?, :master_area?

  def a?
    @master
  end

  View_blog_weight = 1
  View_topic_weight = 1
  Remark_blog_weight = 3
  Comment_topic_weight = 3

  def keep_track_by_weight(weight, follow_id)
    follow_id = follow_id.to_i
    if session[:user_id] and session[:user_id] != follow_id
      if result = Result.find_by_user_id_and_follow_id(session[:user_id], follow_id)
        result.increment(:weight, weight)
      else
        Result.create(:user_id => session[:user_id], :follow_id => follow_id)
      end
    end
  end

  def h(content)
    @template.send(:h, content)
  end

  def u?
    session[:user_id]
  end

  alias_method :u, :u?

  def session_exist?
    false_page unless u?
  end


end

