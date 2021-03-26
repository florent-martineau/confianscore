$( document ).ready(function() {

    $( "#vote_is_validated_true" ).on( "click", function() {
      $("#tag-selector").css("display", "block");
    });

    $( "#source-unvalidated" ).on( "click", function() {
      $("#tag-selector").css("display", "none");
    });
});
