Kind = ["普通","良好","精华","隐藏",'置顶']

function admin_methods(){
    log_show();
    linkOk();
    formOk();
    inputOk();
    show_admin_area();
    convertSelect();
    admin_get_concealed_model_url()
}

function admin_get_concealed_model_url(){
    set = $('.veil')

    set.each(function(i){
        classNames = $(this).getClassNames()
        url = classNames.pop()
        $.get(url, function(message){
            set[i].innerHTML = message
        })
    })


}

function log_show(){
    content = "<a onclick=\"var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var m = document.createElement('input'); m.setAttribute('type', 'hidden'); m.setAttribute('name', '_method'); m.setAttribute('value', 'delete'); f.appendChild(m);var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', '" + window._token + "'); f.appendChild(s);f.submit();return false;\" href=\"/admin/sessions\">注销</a>"
    $('.log_show').html(content)
}
  
function inputOk(){
    var input = $('input[onclick]')

    var array = $.map(input, function(node){
        str = $(node).attr('onclick').toString().replace(/\//, "/admin/")
        return( str.slice( str.indexOf("{") + 1, str.lastIndexOf("}") ) )
    })

    input.attr('onclick', '')
    for(var i in array){
        $(input[i]).click(new Function(array[i]))
    }
}
  
function formOk(){
    array = $('form').filter(function(){
        return !(this.action.match('/admin/'))
    })
    array.each(function(){
        $(this).attr('action', "/admin" + $(this).attr('action'))
    })
}
  
function linkOk(){
    $('a:not([href^=/images]):not([href^=/admin/])').each(
        function(){ 
            $(this).attr('href', "/admin" + $(this).attr('href'))
        })
}
  
function convertSelect(){

    var select_tag = "<select name='kind'><option value=0>普通</option><option value=1>良好</option><option value=2>精华</option><option value=3>隐藏</option><option value=4>置顶</option></select>"
    $('.topic_type').each(

        function(){
            var s_t = $(select_tag)
            s_t.val(
                Kind.indexOf(
                    $.trim(this.innerHTML)
                    )
                )
            var tr = this.parentNode
            $(this).html(
                s_t.change(
                    function(){
                        $.post(find_url(tr), generate_data(this), function(msg, code){
                            if(code == "success")
                                find_board(tr).html("更新成功")
                        })
                    })
                )
        })
}

function show_admin_area(){
    $('.a').show()
}

function find_url(node){
    return $(node).find('a').attr("href") + '/ajax_update'
}

function find_board(node){
    return $(node).find('span')
}

function generate_data(node){
    return({
        kind: $(node).val(),
        authenticity_token: encodeURIComponent(window._token)
    })
}

