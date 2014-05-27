$(document).ready(function() {
  $(".follow").on("click", function(event) {
    event.preventDefault();

    var div = $(this).closest('div')
    console.log(div);
    div.empty();//.append("<div><%= link_to relationship_path(id: user.id), method: :delete, :remote => 'true' do %><button class="unfollow">Unfollow</button></div>");

  });


});
