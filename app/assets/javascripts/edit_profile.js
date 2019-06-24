$(window).on("load", function() {
  $(".open-edit-details").click(function() {
    if ($(".edit-details-content").hasClass("open")) {
      $(".edit-details-content").removeClass("open");
    } else {
      $(".edit-details-content").addClass("open");
    }
  });
});
