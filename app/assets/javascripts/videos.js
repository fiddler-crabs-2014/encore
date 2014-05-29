$(function() {
  $("#setlist a").on("click", function(){
    var songID = $(this).attr("href");
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
            "background-color": "#DC7979",
            "opacity": ".7",
            "z-index": "9999999"
        }).appendTo('body').fadeOut(1000).queue(function() { $(this).remove(); });
}


