/* 
 Assumes:
 - a submit button, 
 - within a form, 
 - within a wrapping div.
*/

$(document).ready(function(){
    $('.ajax_button').click(function() { 
        var parent_div = $(this).parent().parent();
        parent_div.append('<p style="color:green;">Sending...</p>');
        $('form',parent_div).hide();
    });
});
