var songsAndIds = {};
var setListCheckOff = function(button, icon){
  $(button).css('background-color', 'green');
  $(button).val('Added');
  $(button).removeClass('add-song').addClass('remove-song')
  $(icon).removeClass('fa-square-o').addClass('fa-check-square-o');
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

    var authenticity = $this.find('input[name=authenticity_token]').val();
    

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
