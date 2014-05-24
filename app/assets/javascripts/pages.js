var songsAndIds = {};
$(document).ready(function() {
  $('.add-song').on("click", function(e) {
    e.preventDefault();

    var $this = $(this);
    var songId = $this.find('.song_id').val();
    var songTitle = $this.find('.song').val();
  })

  $("#save_concert").on("click", function(e){
    e.preventDefault();
    var concertInfo = $(this).closest("form").serialize();
    var songList = $.param({ songs: songsAndIds });
    $.ajax({
      url: "create_concert",
      method: "post",
      data: (concertInfo + '&' + songList)
    });
  })
})

