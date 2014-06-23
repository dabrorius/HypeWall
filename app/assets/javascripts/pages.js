var verticalAnchors = ['anchor-left','anchor-right'];
var horizontalAnchors = ['anchor-up','anchor-down'];

var maxPosition = 5;

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
    nextPosition = (nextPosition + 1) % maxPosition;
  });
}


function addFrame( position ) {
  $("#photo-frame-" + position).addClass("animated slideInRight").removeClass("hide");
  return { 'addFrame': this }
}

function removeFrame( position ) {
  var frameSelector = "#photo-frame-"+position;
  $(frameSelector).addClass("animated slideOutLeft").
  one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', 
    function(){ $(frameSelector).remove(); }
  );
}

function panImage( position ) {
  var frameSelector = "#photo-frame-"+position;
  $(frameSelector + " img").animate({height: "110%"}, 5000)
}

function loadUnload() {
  addFrame(0)
  setTimeout(function() { addFrame(1) }, 500);
  setTimeout(function() { addFrame(2) }, 1000);
  setTimeout(function() { addFrame(3) }, 1500);

  setTimeout(function() { panImage(0)}, 2000 );
  setTimeout(function() { panImage(1)}, 7000 );
  setTimeout(function() { panImage(2)}, 12000 );
  setTimeout(function() { panImage(3)}, 17000 );

  setTimeout(function() { removeFrame(3) }, 25000);
  setTimeout(function() { removeFrame(2) }, 25500);
  setTimeout(function() { removeFrame(1) }, 26000);
  setTimeout(function() { removeFrame(0) }, 26500);
}

function loadNewFrames() {
  $.get( "/frames", function( data ) {
    $(".wall").html(data);
    loadUnload();
  });
  setTimeout( loadNewFrames, 28000);
}

$(document).ready(function(){
  loadNewFrames();
});
