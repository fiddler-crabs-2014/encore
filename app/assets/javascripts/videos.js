$(function() {
  $("#setlist a").on("click", function(e){
    e.preventDefault();
    var songID = $(this).attr("href");
    var songOffset = $(songID).offset().top;
    $('body').animate({
      scrollTop: songOffset - 75
    });
    highlight(songID);
  })
});

function highlight(id) {
    var el = $(id);
    $("<div/>")
    .width(el.outerWidth())
        .height(el.outerHeight())
        .css({
            "position": "absolute",
            "left": el.offset().left,
            "top": el.offset().top,
            "background-color": "white",
            "opacity": ".7",
            "z-index": "9999999"
        }).appendTo('body').fadeOut(1000).queue(function() { $(this).remove(); });
}


