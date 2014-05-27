<<<<<<< HEAD
// $(document).ready(function() {

//   $('.new_relationship').submit(function(event) {
//     event.preventDefault();

//     var userId = $(this).find('#relationship_followed_id').val();
//     var token = $(this).find('input[name=authenticity_token]').val();
//     $.ajax({
//       type: "POST",
//       url: "/relationships",
//       data: { user_id: userId, authenticity_token: token }
//     }).done(function() {
//       $(this).find('#follow_btn').val('Unfollow');
//     })
//   });

//   //should be delete_relationship
//   $('.edit_relationship').submit(function(event) {
//     event.preventDefault();


//     var userId = $(this).find('#relationship_followed_id').val();
//     var token = $(this).find('input[name=authenticity_token]').val();
//     $.ajax({
//       type: "DELETE",
//       url: "/relationship",
//       data: { user_id: userId, authenticity_token: token }
//     }).done(function() {
//       $(this).find('#follow_btn').val('Follow');
//     })
//   });
// });

