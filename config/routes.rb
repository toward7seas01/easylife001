ActionController::Routing::Routes.draw do |map|
  map.connect "sessions/stats", :controller => 'sessions', :action => 'stats'
  map.resources :forums, :only => [:index, :show] do |forum|
    forum.resources :topics, :except => :index, :new => {:new => [:get, :post]} do |topic|
      topic.resources :comments, :except => [:index, :show], :new => {:new => [:get, :post]}
    end
  end
  map.connect "forums/:forum_id/topics/:id/edit", :controller => "topics", :action => "edit"
  map.connect "forums/:forum_id/topics/:topic_id/comments/:id/edit", :controller => "comments", :action => "edit"

  map.resources :users, :except => :index, :member => {:info => :get } do |user|
    user.resources :blogs, :member => {:ajax_vote_up => :post, :ajax_vote_down => :post, :ajax_check => :get } do |blog|
      blog.resources :remarks, :except => :index
    end
    user.resources :profiles, :only => [:new, :create, :update]
    user.resources :categories, :only => :show
    user.resources :banners, :only => [:new, :create, :update]

    user.resources :covers do |cover|
      cover.resources :images, :except => [:index, :show], :member => {:set_cover => :post }
    end
  end

  map.with_options :controller => 'images' do |path|
    precede_path = "/users/:user_id/covers/:cover_id/images/"
    new_path = {:ready_batch_delete => :get, :ready_batch_update => :get, :batch_update => :put, :batch_delete => :delete}
    new_path.each do |name, method|
      path.send(name, precede_path + name.to_s, :action => name.to_s )
    end
  end

  map.with_options :controller => 'say', :conditions => {:method => :get} do |path|
    path.home "/", :action => 'hello'
    path.connect ":action", :action => /ok|p_blogs|p_topics|p_bloggers|contact|about/
  end

  map.resource :sessions, :only => [:new, :create, :destroy]
  map.resources :feeds, :except => [:edit, :update], :collection => {:favourite => :get}

  map.with_options :controller => 'search' do |path|
    path.search 'search', :action => 'index'
    path.connect 'search/:action', :action => /blog_search|comment_search|user_search/
  end

  map.total 'blogs/total', :controller => 'blogs', :action => 'total'
  map.resources :admins
  map.resources :msgs, :only => [:index, :create]
  map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
  map.with_options :controller => "users" do |path|
    path.user_show "/users/:id/:page", :action => "show"
    path.connect "/users/activation/:num", :action => 'activation'
  end
  
  map.connect ':controller/:id', :action => "show", :controller => /comments|remarks/
  map.connect 'admin/:controller/:action/:id', :action => /conceal|unconceal/
  map.connect 'admin/:controller/:id', :action => "show", :controller => /comments|remarks/
  map.with_options :controller => "categories" do |path|
    path.connect "admin/categories", :action => "index"
    path.connect "admin/categories/:id", :action => "destroy"
  end
  map.namespace "admin" do |admin|
    admin.resources :forums, :member => {:show_concealed_topics => :get, :aconceal => :post, :aunconceal => :post } do |forum|
      forum.resources :topics, :except => :index, :new => {:new => [:get, :post]}, :member => {:ajax_update => :post} do |topic|
        topic.resources :comments, :except => [:index, :show], :new => {:new => [:get, :post]}
      end
    end
    admin.connect "forums/:forum_id/topics/:id/edit", :controller => "topics", :action => "edit"
    admin.connect "forums/:forum_id/topics/:topic_id/comments/:id/edit", :controller => "comments", :action => "edit"

    
    admin.resources :users, :except => :index, :member => {:info => :get } do |user|
      user.resources :blogs, :member => {:ajax_vote_up => :post, :ajax_vote_down => :post, :ajax_check => :get } do |blog|
        blog.resources :remarks, :except => :index
      end
      user.resources :profiles, :only => [:new, :create, :update]
      user.resources :categories, :only => :show
      user.resources :banners, :only => [:new, :create, :update]

      user.resources :covers do |cover|
        cover.resources :images, :except => [:index, :show], :member => {:set_cover => :post }
      end
    end

    admin.with_options :controller => 'images' do |path|
      precede_path = "/users/:user_id/covers/:cover_id/images/"
      new_path = {:ready_batch_delete => :get, :ready_batch_update => :get, :batch_update => :put, :batch_delete => :delete}
      new_path.each do |name, method|
        path.send(name, precede_path + name.to_s, :action => name.to_s )
      end
    end

    admin.with_options :controller => 'say', :conditions => {:method => :get} do |path|
      path.home "/", :action => 'hello'
      path.connect ":action", :action => /ok|p_blogs|p_topics|p_bloggers|contact|about/
    end

    admin.resource :sessions, :only => [:new, :create, :destroy]
    admin.resources :feeds, :except => [:edit, :update], :collection => {:favourite => :get}

    admin.with_options :controller => 'search' do |path|
      path.search 'search', :action => 'index'
      path.connect 'search/:action', :action => /blog_search|comment_search|user_search/
    end

    admin.total 'blogs/total', :controller => 'blogs', :action => 'total'
    admin.resources :admins
    admin.resources :msgs, :only => [:index, :create, :destroy], :collection => {:admin_index => :get}
    admin.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
    admin.with_options :controller => "users" do |path|
      path.user_show "/users/:id/:page", :action => "show"
      path.connect "/users/activation/:num", :action => 'activation'
    end
 
    #    admin.resources :categories, :only => [:index, :destroy]
  
  end

end

