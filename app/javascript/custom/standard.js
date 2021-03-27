document.addEventListener("turbolinks:load", function() {

    $( "#source-validated" ).on( "click", function() {
      $("#tag-selector").css("display", "block");
    });

    $( "#source-unvalidated" ).on( "click", function() {
      $("#tag-selector").css("display", "none");
    });
});
