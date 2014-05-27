var songsAndIds = {};
$(document).ready(function() {

  var concert_info = _.pairs(concerts);

  var band_name = band;

  _.each(concert_info, function(value, key, list) {

    var concert_details = value[0].split(", ");
    var date = concert_details[0];
    var tour = concert_details[1];
    var venue = concert_details[2];
    var city_state = concert_details[3] + ", " + concert_details[4];
    $('.concert-listings ol').append("<li class='concert-listing'><a href='#'>" + date + ", " + tour + ", " + venue +
                                     "<br>" + city_state + "</a><hr></li>");
  })

  _.each(concert_info, function(value, key, list) {
      $('ol li:nth-child('+ (key + 1) + ') > a').attr("href", "/search_youtube?band=" + band + "&concert=" + value[0] + "&songs=" + value[1]);
  })

  $('.add-song').on("submit", function(e) {
    e.preventDefault();
    var form = $(this).closest("form");

    var youtubeTitle = form.find('#yt-title').text();
    var songId = form.find('#song_id').val();
    var songTitle = form.find('select').val();

    songsAndIds[songId] = songTitle;

    var songEl = ""
    var authenticity = form.find('input[name=authenticity_token]').val();

    songEl += "<p>"
    songEl += songTitle + " - "
    songEl += youtubeTitle
    songEl += "</p>"

    $('#added_songs').append(songEl);

    $.post('/songs', { song: songTitle,
                       song_id: songId,
                       concert_id: concertId,
                       artist_id: artistId,
                       authenticity_token: authenticity})
      .done(function(data) {
        console.log(data);
        $('#flash').empty();
        $('#flash').append('<div class="alert alert-success">' + data + '</div>');
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
