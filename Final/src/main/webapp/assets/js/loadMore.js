/**
 * loadMore 
 */
$(document).ready(function(){
      $(".songDetail").slice(0, 4).show();
      $("#loadMore").on("click", function(e){
        e.preventDefault();
        $(".songDetail:hidden").slice(0, 4).slideDown();
        //if($(".songDetail:hidden").length == 0) {
         // $("#loadMore").text("No Content").addClass("noContent");
        //}
      });
    });