$(document).ready(function() {
  $('.follow').click(function(event) {
    event.preventDefault();

    var following_element = $(this).closest('.following');
    var user_id = following_element.data('user-id');

    $.ajax({
      type: "POST",
      url: "/relationships",
      data: {  followed_id: user_id }
    }).done(function(data) {
      following_element.removeClass('following_false').addClass('following_true');
    }).fail(function() {
      alert('Following failed!!!!!!');
    });
  });

  $('.unfollow').click(function(event) {
    event.preventDefault();

    var following_element = $(this).closest('.following');
    var user_id = following_element.data('user-id');

    $.ajax({
      type: "POST",
      url: "/relationships/unfollow",
      data: {  followed_id: user_id }
    }).done(function(data) {
      following_element.removeClass('following_true').addClass('following_false');
    }).fail(function() {
      alert('Unfollow has failed you!!');
    });
  });

});
  // $('.new_relationship').submit(function(event) {
  //   event.preventDefault();

  //   var div = $(this).closest('.follow_wrapper');
  //   var child = div.children();
  //   console.log(child);

  //   // var userId = $(this).find('#relationship_followed_id').val();
  //   // var token = $(this).find('input[name=authenticity_token]').val();
  //   // $.ajax({
  //   //   type: "POST",
  //   //   url: "/relationships",
  //   //   data: { user_id: userId, authenticity_token: token }
  //   // }).done(function() {
  //   //   $(this).find('#follow_btn').val('Unfollow');
  //   // })
  // });

  //should be delete_relationship


