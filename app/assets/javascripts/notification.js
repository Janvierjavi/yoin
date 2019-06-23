$(window).on("load", function() {
  setTimeout(function() {
    $(".notification-footer").fadeOut("slow");
  }, 3000);

  $(".sutegana-rule").click(function() {
    $(".sutegana-rule-explanation").addClass("open");
    $(".general-container").addClass("dark");
  });

  $(".close-sutegana-rule-explanation").click(function() {
    $(".sutegana-rule-explanation").removeClass("open");
    $(".general-container").removeClass("dark");
  });
});
