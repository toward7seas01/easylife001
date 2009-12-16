function show_feed(){
    $('select').change(function(){
        if(this.value){
            $.get("/feeds/" + this.value, function(data){
                $('#change').html(data)
            })
        }
    })
}

$(function(){
    show_feed()
})
