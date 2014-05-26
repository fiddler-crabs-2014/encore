$(document).ready(function() {
  $('#add_attendee_btn').click(function(event) {
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
      });
  });
});
