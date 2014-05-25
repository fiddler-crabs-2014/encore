var songsAndIds = {};
$(document).ready(function() {

  $('.add-song-btn').on("click", function(e) {
    e.preventDefault();
    var form = $(this).closest("form");
    var youtubeTitle = form.find('#yt-title').text();
    var songId = form.find('.song_id').val();
    var songTitle = form.find('select').val();
    songsAndIds[songId] = songTitle;
    // console.log(songsAndIds);
    var songEl = ""
    songEl += "<p>"
    songEl += songTitle + " - "
    songEl += youtubeTitle
    songEl += "</p>"
    console.log(songEl);
    $('#added_songs').append(songEl);
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
