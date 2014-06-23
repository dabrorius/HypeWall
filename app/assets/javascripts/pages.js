
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
