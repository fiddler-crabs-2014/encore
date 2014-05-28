var songsAndIds = {};
var setListCheckOff = function(button, icon){
  $(button).css('background-color', 'green');
  $(button).val('Add Song');
  $(button).removeClass('add-song').addClass('remove-song')
  $(icon).removeClass('fa-circle-o').addClass('fa-check-circle-o');
}

var removeListCheckOff = function(button, icon){
  $(button).css('background-color', 'red');
  $(button).val('Added');
  $(button).removeClass('remove-song').addClass('add-song')
  $(icon).removeClass('fa-check-circle-o').addClass('fa-circle-o');
}
$(document).ready(function() {

  $('.add-song').on("submit", function(e) {
    e.preventDefault();
    var $this = $(this);
    console.log($this);

    var youtubeTitle = $this.find('#yt-title').text();
    var songId = $this.find('#song_id').val();
    var songTitle = $this.find('select').val();
    var button = $this.find('input#add-song');
    console.log(button);
    songsAndIds[songId] = songTitle;

    var songEl = ""
    var authenticity = $this.find('input[name=authenticity_token]').val();

    songEl += "<p>"
    songEl += songTitle + " - "
    songEl += youtubeTitle
    songEl += "</p>"

    $('#added_songs').append(songEl);
    

    $.post('/songs', { song: songTitle,
                       song_id: songId,
                       concert_id: concertId,
                       artist_id: artistId,
                       playlist_id: playlistId,
                       authenticity_token: authenticity})

      .done(function(data) {
        var setListedSong = $('ol.set-songs').find('li:contains('+ songTitle+ ')');
        var icon = setListedSong.find('i');
        $this.find('input[name=commit]').attr('disabled', 'disabled');
        $('#flash').empty();
        $('#flash').append('<div class="alert alert-success">' + data + '</div>')
        setListCheckOff(button, icon);
        // $(button).css('background-color', 'green');
        // $(button).val('Added');
        // $(icon).removeClass('fa-circle-o').addClass('fa-check-circle-o');
        // console.log(icon);

      });
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
