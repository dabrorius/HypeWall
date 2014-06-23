
function addFrame( position ) {
  $("#photo-frame-" + position).addClass("animated slideInRight").removeClass("hide");
}

function removeFrame( position ) {
  var frameSelector = "#photo-frame-"+position;
  $(frameSelector).addClass("animated slideOutLeft").
  one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', 
    function(){ $(frameSelector).remove(); }
  );
}

function panImage( position ) {
  var image = $("#photo-frame-"+position+" img");
  var frame = $("#photo-frame-"+position);

  //frame.animate({height: "110%"}, 5000)
  var frameWidth = frame.width();
  var imageWidth = image.width();
  var panDistanceX = (imageWidth - frameWidth);


  var frameHeight = frame.height();
  var imageHeight = image.height();
  var panDistanceY = (imageHeight - frameHeight);

  var animateObject = {};
  animateObject.left = "-"+panDistanceX+"px";
  animateObject.top = "-"+panDistanceY+"px";

  if( frameWidth > frameHeight ) {
    animateObject.width = "110%";
  }
  else {
    animateObject.height = "110%";
  }

  image.animate(animateObject, 5000)
}

function loadUnload() {
  var loadDelay = 500;
  var panDelay = 5000;

  var loadAt = 0;

  addFrame(loadAt)
  loadAt += loadDelay;

  setTimeout(function() { addFrame(1) }, loadAt);
  loadAt += loadDelay;

  setTimeout(function() { addFrame(2) }, loadAt);
  loadAt += loadDelay;

  setTimeout(function() { addFrame(3) }, loadAt);
  loadAt += loadDelay;

  setTimeout(function() { panImage(0)}, loadAt );
  loadAt += panDelay;

  setTimeout(function() { panImage(1)}, loadAt );
  loadAt += panDelay;

  setTimeout(function() { panImage(2)}, loadAt );
  loadAt += panDelay;

  setTimeout(function() { panImage(3)}, loadAt );
  loadAt += panDelay;


  setTimeout(function() { removeFrame(3) }, loadAt);
  loadAt += loadDelay;

  setTimeout(function() { removeFrame(2) }, loadAt);
  loadAt += loadDelay;

  setTimeout(function() { removeFrame(1) }, loadAt);
  loadAt += loadDelay;

  setTimeout(function() { removeFrame(0) }, loadAt);
  loadAt += loadDelay;
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
