$(window).on("load", function() {
  $(".tab").each(function(index, clickedTab) {
    $(clickedTab).click(function() {
      $(".tab").each(function(index, tab) {
        $(tab).removeClass("active");
      });
      $(clickedTab).addClass("active");
    });
  });
});
