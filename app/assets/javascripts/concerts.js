$(document).ready(function() {

  var token = $( 'meta[name="csrf-token"]' ).attr( 'content' );

  $.ajaxSetup( {
    beforeSend: function ( xhr ) {
      xhr.setRequestHeader( 'X-CSRF-Token', token );
    }
  });

  $('#create_attended_concert').submit(function(event) {
    event.preventDefault();

    var form = $(this).closest("form");
    var concertId = form.find('#concert').val();
    var userId = form.find('#user').val();
    var authenticity = form.find('input[name=authenticity_token]').val();

    $.post('/attended_concerts', { user_id: userId,
                                  concert_id: concertId,
                                  authenticity_token: authenticity})
      .done(function(data) {
        console.log(data);
        $('#flash').append('<div class="alert alert-success">' + data + '</div>');
        $('#add_attendee_btn').replaceWith("<div id='buttons' style='margin-right: 2.12766%'><button class='added'><h4>I attended this concert</h4></button></div>");
      });
  });

  $('.report-video').on('click', function(e) {
    e.preventDefault();
    var $this = $(this);

    var videoId = $this.data('video-id');

    if ($this.text() == "Report Video") {

      $.post('/flag_video', { video_id: videoId })
        .done(function(resp) {
          $this.closest('.video-container').addClass('flagged');
          $this.closest('span').empty();
          $this.text("Unflag");
        })
    } else {
      $.post('/unflag_video', { video_id: videoId})
        .done(function(resp) {
          $this.closest('.video-container').removeClass('flagged');
          $this.text("Report Video");
        })
    }
  })
});
