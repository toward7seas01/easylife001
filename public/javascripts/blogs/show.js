$(function(){
    $.get(location.href + "/ajax_check", function(message){
        if(message == "true")
            $('.vote').show();
    })
})

