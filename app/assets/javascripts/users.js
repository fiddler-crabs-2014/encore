$(document).ready(function() {
  $(".follow_btn").on("click", function(event) {
    event.preventDefault();

    console.log("Follow button pressed");

    var user = $(this).closest('div')
    console.log(user)
  })


})
