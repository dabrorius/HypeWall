var verticalAnchors = ['anchor-left','anchor-right'];
var horizontalAnchors = ['anchor-up','anchor-down'];

function pushImage(position, url, animation) {
  var frameSelector = "#photo-frame-"+position;
  $(frameSelector + " img").addClass("to-remove");
  var verticalAnchor = verticalAnchors[Math.floor(Math.random()*verticalAnchors.length)];
  var horizontalAnchor = horizontalAnchors[Math.floor(Math.random()*horizontalAnchors.length)];
  $(frameSelector).append("<img class='animated "+ animation +" "+ verticalAnchor +" "+ horizontalAnchor +"' src='"+url+"'>").
  one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', 
    function(){
      $(frameSelector + " .to-remove").remove();
      $(frameSelector + " img").animate({height: "110%"}, 5000)
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

setInterval(fetchNextImage, 5000);