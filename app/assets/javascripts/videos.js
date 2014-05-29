$(function() {
  highlight();
  $("#setlist a").on("click", function(){
    var songID = $(this).attr("href");
    $(songID).click();
  })
});


function highlight() {
   $(".video-box").on("click", function() {
    var el = $(this);
    $("<div/>")
    .width(el.outerWidth())
        .height(el.outerHeight())
        .css({
            "position": "absolute",
            "left": el.offset().left,
            "top": el.offset().top,
            "background-color": "#ffff99",
            "opacity": ".7",
            "z-index": "9999999"
        }).appendTo('body').fadeOut(1000).queue(function () { $(this).remove(); });
    });
}


