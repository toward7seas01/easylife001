module ApplicationHelper

  def show_banner(&block)
    attributes = {:id => "banner", :style => "background: #000 url(/images/index/img04.jpg) no-repeat left top;"}
    attributes[:style] = "background: #000 url(#{ @current_banner.public_filename(:thumb) }) no-repeat left top;" if @current_banner.try(:show?)
    content_tag("div", attributes, &block)
  end
  
  def divide_page(page)
    will_paginate page, :previous_label => '上一页', :next_label => '下一页'
  end

  alias_method :d_p, :divide_page

  def head(c, j = [])
    content_for :head do
      [stylesheet_link_tag(*c), javascript_include_tag(*j)]
    end
  end

  def js(*file_name)
    content_for :head do
      javascript_include_tag(*file_name)
    end
  end

  def css(*file_name)
    content_for :head do
      stylesheet_link_tag(*file_name)
    end
  end

  def truncate_u(text, length = 30, truncate_string = "...")
    l = 0
    char_array = text.unpack("U*")
    char_array.each_with_index do |c,i|
      l = l + ( c < 127 ? 0.5 : 1)
      if l >= length
        return char_array[0..i].pack("U*") + (i < char_array.length - 1 ? truncate_string : "")
      end
    end
    return text
  end

  def show_searched_result(content, keys)
    highlight(simplicify(excerpt(content, keys.first, 50)), keys)
  end

  def show_truncated_or_excerpted(content, *keys)
    if controller.controller_name == "search"
      show_searched_result(content, keys)
    else
      simplicify truncate_u(content, 100, "....省略#{content.mb_chars.size - 100}字")
    end
  end

  def simplicify(content)
    sanitize content, :tags => []
  end

  alias_method :spy, :simplicify

  def vanish
    page << %(setTimeout("$('.a_l_i').remove()", 3000))
  end

  def origa_layout
    render :partial => "layouts/application"
  end

  def idf_class(model)
    ".#{dom_id(model)}"
  end

  def control_display(user)
    "u #{user_identifier(user)}"
  end

  alias_method :c, :control_display

  def user_identifier(user)
    "c#{user.id}"
  end

  def page_user_control_display
    @u_c ||= "u c#{page_user_id}"
  end
  
  alias_method :u_c, :page_user_control_display

  methods = {"conceal" => '隐藏', "unconceal" => "重现"}

  methods.each do |key, value|
    define_method key.to_sym do |model|
      link_to_remote value, :url => model.send(:"#{key}_path")
    end
  end

  def stats(model)
    if model.conceal?
      "<span class='stats conceal #{dom_id(model)}'>已隐藏</span>"
    else
      "<span class='stats #{dom_id(model)}'></span>"
    end
  end

  def s(model)
    render :partial => "say/s", :locals => {:model => model}
  end
  
  def display(model)
    if show?(model)
      yield if block_given?
    else
      concat "<p>该项已被隐藏</p>"
    end
  end

  def judge_content(model)
    if model.show?
      content_tag(:p, (sanitize model.content))
    else
      content_tag(:p, "该项已被隐藏", :class => "veil " + user_identifier(model.user) + " /#{dom_class(model).pluralize}/#{model.id}" )
    end
  end

  alias_method :j_c, :judge_content

  def thumb_image(image, options = {})
    image_tag(image.public_filename(:thumb), options)
  end

  def show_profile(profile)
    if profile.show?
      thumb_image(profile)
    else
      thumb_image(alternate_profile)
    end
  end

  def method_finder(name)
    if ApplicationHelper.instance_methods.include? name
      send(name)
    else
      name
    end
  end

  methods = {"l_s" => "session", "l_a" => "a", "l_c" => "u_c"}
  methods.each do |key, value|
    module_eval <<-EOF, __FILE__, __LINE__ + 1
        def #{key}(*args, &block)
          options = args.extract_options!.merge :class => method_finder("#{value}")
          link_to(*(args << options), &block)
        end
    EOF
  end

  def l(*args, &block)
    link_to(*args, &block)
  end

  add_methods(:l_d, :l_c_d, :l_a_d) do |*args|
    options = args.extract_options!.reverse_merge :confirm => '你确定吗?', :method => :delete
    args.unshift("删除")
    send(__method__.to_s.chomp("_d"), *(args << options))
  end

  def l_r_s(name, options = {}, html_options = nil)
    options.merge! :html => {:class => "session"}
    link_to_remote(name, options, html_options)
  end


  def render_user_partial(local)
    render :partial => '/users/new_user', :locals => {:u => local }
  end
 
end

