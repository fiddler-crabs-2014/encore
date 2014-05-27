$(document).ready(function() {

  $('form').submit(function(event) {
    event.preventDefault();

    var params = $(this).serialize();
    console.log(params);
  $.ajax({
    type: "POST",
    url: relationships_path
    data: params

  })
  });
});
