$.fn.getClassNames = function(){
    if(name = this.attr("className")){
        return name.split(" ");
    }
    else{
        return [];
    }
}



function cancel(){
    $('.a_l_i a[href=X]').one('click', function(){
        $('.a_l_i').remove()
        return false;
    })
}

function idf(id){
    return ".c" + id
}

function insert_session_partial(user){
    $('#log').prepend(user.name);
    li = "<li><a href='/users/" + user.id + "/blogs'>个人空间</a></li><li><a href='/users/" + user.id + "/covers'>我的相册</a></li><li><a href='/feeds'>我的订阅</a></li>";
    $('.current_page_item').after(li);
    $('#sidebar > ul').prepend(blog_layout_partial(user))
}

function show_and_hide(user){
    $('.session, ' + idf(user.id)).show();
    $('.un_session').hide();
}

function user_or_visitor(){
    $.getJSON("/sessions/stats", function(user){
        change_user_content(user)
        if(user.id){           
            show_and_hide(user);
            insert_session_partial(user);
            get_concealed_model_url(user);
        }
        if(user.admin){
            admin_methods();

        }
    })
    
}

function change_user_content(user){
    user.id = user.user_id
    user.name = user.user_name
    user.admin = user.a_area
    delete_content(user, "user_id", "user_name", "a_area")
}

function delete_content(object){
    for(var i = 1; i< arguments.length; i++){
        delete object[arguments[i]]
    }
}

function page_user_id(){
    path = location.pathname.split("/")
    index = path.indexOf("users") + 1
    return path[index]
}


function blog_layout_material(){
    return "<li>\
              <h2>管理</h2>\
              <ul>\
                <li><a href='/users/place/blogs'>博客管理</a></li>\
                <li><a href='/users/place/blogs/new'>写新博客</a></li>\
                <li><a href='/users/place/profiles/new'>头像</a></li>\
                <li><a href='/users/place/banners/new'>博客上方的图片</a></li>\
              </ul>\
           </li>\
           <li>\
              <h2>我的……</h2>\
              <ul>\
                <li><a href='/users/place/covers'>相册</a></li>\
                 <li><a href='/users/place/info'>资料</a></li>\
              </ul>\
          </li>"
}

function blog_layout_partial(user){
    return blog_layout_material().split("place").join(user.id)
}



function get_concealed_model_url(user){
    set = $('.veil' + idf(user.id))

    set.each(function(i){
        classNames = $(this).getClassNames()
        url = classNames.pop()
        $.get(url, function(message){
            set[i].innerHTML = message
        })
    })


}




$(function(){
    user_or_visitor()
})










