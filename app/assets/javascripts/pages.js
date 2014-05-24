songsAndIds = {}
$(document).ready(function() {
  $('.add-song-btn').on("click",function(event) {
    event.preventDefault();

    var $this = $(this);
    console.log($this)

    var songId = $this.find('.song_id').val();
    var songTitle = $this.find('.song').val();

    console.log(songId);

    // songsAndIds[songId] = songTitle
    // console.log(songsAndIds);
  })
})







