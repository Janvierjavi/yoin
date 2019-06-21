$(window).on("load", function() {
  $(".fa-bars").click(function() {
    if ($(".acd-menu-item").hasClass("open")) {
      $(".acd-menu-item").removeClass("open");
    } else {
      $(".acd-menu-item").addClass("open");
    }
  });
});
