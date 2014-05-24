var songsAndIds = {};
$(document).ready(function() {

  $('.add-song').on("click", function(e) {
    e.preventDefault();

    var $this = $(this);

    var songId = $this.find('.song_id').val();
    var songTitle = $this.find('.song').val();

    songsAndIds[songId] = songTitle
    console.log(songsAndIds);
  })

  $("#save_concert").on("click", function(e){
    e.preventDefault();
    var concertInfo = $(this).closest("form").serialize();
    var songList = $.param({ songs: songsAndIds });
    console.log("CAN I DO THIS?????");
    console.log(songsAndIds);
    // console.log($.param(songsAndIds));
    // console.log($.param({ song: { "song1": 1, "song2": 2 } }));
    // console.log("CAN I DO THIS?????");
    console.log(concertInfo + '&' + songList);
    $.ajax({
      url: "create_concert",
      method: "post",
      // data: $.param({ song: { "song1": 1, "song2": 2 } })
      data: (concertInfo + '&' + songList)
    });
  })



})
