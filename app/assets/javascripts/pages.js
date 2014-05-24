var songsAndIds = {};
$(document).ready(function() {

  $('.add-song-btn').on("click", function(e) {
    e.preventDefault();
    var form = $(this).closest("form");
    var songId = form.find('.song_id').val();
    var songTitle = form.find('select').val();
    console.log(songTitle);
    songsAndIds[songId] = songTitle;
    console.log(songsAndIds);
  });

  $("#save_concert").on("click", function(e){
    e.preventDefault();
    var concertInfo = $(this).closest("form").serialize();
    var songList = $.param({ songs: songsAndIds });
    $.ajax({
      url: "create_concert",
      method: "post",
      data: (concertInfo + '&' + songList)
    });
  });
});
