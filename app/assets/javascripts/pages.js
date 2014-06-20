function pushImage(position, url, animation) {
  var frameSelector = "#photo-frame-"+position;
  $(frameSelector + " img").addClass("to-remove");
  $(frameSelector).append("<img class='animated "+ animation +"' src='"+url+"'>").
  one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', 
    function(){
      $(frameSelector + " .to-remove").remove();
    });
}

var availableAnimations = ['flipInX', 'flipInY','bounceInDown','bounceInUp','bounceInLeft','bounceInRight'];
var nextPosition = 0;
function fetchNextImage() {
  $.get( "/images/next", function( data ) {
    var animation = availableAnimations[Math.floor(Math.random()*availableAnimations.length)];
    pushImage(nextPosition, data.url, animation);
    nextPosition = (nextPosition + 1) % 6;
  });
}

setInterval(fetchNextImage, 3000);