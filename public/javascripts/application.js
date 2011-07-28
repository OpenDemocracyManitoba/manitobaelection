(function($){
  $.fn.shuffle = function() {
    return this.each(function(){
      var items = $(this).children();
      return (items.length)
        ? $(this).html($.shuffle(items))
        : this;
    });
  }

  $.shuffle = function(arr) {
    for(
      var j, x, i = arr.length; i;
      j = parseInt(Math.random() * i),
      x = arr[--i], arr[i] = arr[j], arr[j] = x
    );
    return arr;
  }
})(jQuery);

$(document).ready(function(){
    $('div.politicians').shuffle();
    $('.ajax_button').click(function() { 
        var parent_div = $(this).parent().parent();

        parent_div.append('<p style="color:green;">Sending...</p>');
        $('form',parent_div).hide();

    });

});
