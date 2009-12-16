jQuery(function(){
    show_dialog()
});

function show_dialog(){
    $("#dialog").dialog({
        bgiframe: true,
        modal: true,
        buttons: {
            Ok: function() {
                $(this).dialog('close');
            }
        }
    });
}




