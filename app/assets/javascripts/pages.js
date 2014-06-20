function pushImage(position, url, animation) {
  var frameSelector = "#photo-frame-"+position;
  $(frameSelector + " img").addClass("to-remove");
  $(frameSelector).append("<img class='animated "+ animation +"' src='"+url+"'>").
  one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', 
    function(){
      $(frameSelector + " .to-remove").remove();
    });
}

var nextPosition = 0;
function fetchNextImage() {
  $.get( "/images/next", function( data ) {
    $( ".result" ).html( data );
    pushImage(nextPosition, data.url, 'flipInX');
    nextPosition = (nextPosition + 1) % 6;
  });
}

setInterval(fetchNextImage, 3000);