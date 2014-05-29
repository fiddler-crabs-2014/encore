jQuery.fn.highlight = function() {
    $(".video-box").on("click", function() {
        $(this).css({
                "background-color": "#ffff99",
                "opacity": ".9"
            })
            .fadeOut(500);
    });
}
