jQuery(function(){
    ui_tab()
    chat();
})

function chat(){
    $('#chat_form form').ajaxForm({
        url: '/msgs',
        clearForm: true
    })


    $('#chat_form textarea').keypress(
        function(event){
            if((event.which == 13)&&(event.shiftKey))
                $('#chat_form form').submit()
        })



    // notice the 'good' id
    if(document.getElementById('chat')){
        setInterval(function(){
            $.get("/msgs", function(msg){
                $('#ok').html(msg)
            } )
        }, 2000)
    }

}

function ui_tab(){
    $('#rotate').tabs()
}





