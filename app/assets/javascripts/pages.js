songsAndIds = {}
$(document).ready(function() {
  $('.add-song').submit(function(e) {
    e.preventDefault();

    var $this = $(this);

    var songId = $this.find('.song_id').val();
    var songTitle = $this.find('.song').val();

    songsAndIds[songId] = songTitle
    console.log(songsAndIds);
  })
})
