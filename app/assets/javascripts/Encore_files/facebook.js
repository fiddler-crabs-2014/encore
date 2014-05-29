(function() {
  jQuery(function() {
    $('body').prepend('<div id="fb-root"></div>');
    return $.ajax({
      url: "" + window.location.protocol + "//connect.facebook.net/en_US/all.js",
      dataType: 'script',
      cache: true
    });
  });

}).call(this);
