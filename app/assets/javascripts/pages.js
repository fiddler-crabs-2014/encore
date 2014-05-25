var songsAndIds = {};
$(document).ready(function() {
  $('.add-song').on("submit", function(e) {
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

    $.post('/songs', { song: songTitle })
      // .done(function(data) {
      //   $.each('.set-song', function(index, value) {
      //     $('.set-song:contains(' + data.song + ')')
      //   })
      // })
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

  $('.remove-video').on('click', function(e) {
    e.preventDefault();
    var $this = $(this);

    console.log($this.closest('.add-song'));
    $this.closest('.add-song').remove();
  })
});
