$(window).on("load", function() {
  $(".top-tanka-line")
    .css({
      opacity: "0.0"
    })
    .animate(
      {
        opacity: "1.0"
      },
      1500
    );

  $(".kwsk").click(function() {
    $(".top-tanka-line").removeClass("hide");
    $(".kwsk").addClass("hide");
    $(".seven")
      .css({
        opacity: "0.0"
      })
      .animate(
        {
          opacity: "1.0"
        },
        1500
      );
  });

  $(".sign-x-button-in-top").each(function(index, hoverdButton) {
    $(hoverdButton).hover(function() {
      $(".sign-x-button-in-top").each(function(index, button) {
        $(button).addClass("moderate");
      });
      $(hoverdButton).removeClass("moderate");
    });
  });
});
