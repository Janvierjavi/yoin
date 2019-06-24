$(window).on("load", function() {
  $(".sutegana-rule").click(function() {
    $(".sutegana-rule-explanation").addClass("open");
    $(".general-container").addClass("dark");
  });

  $(".close-sutegana-rule-explanation").click(function() {
    $(".sutegana-rule-explanation").removeClass("open");
    $(".general-container").removeClass("dark");
  });
});
