function animatePhoto(photoId, animation) {
  $("#photo-"+photoId).removeClass().addClass('animated ' + animation).one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
    $(this).removeClass();
  });
}


function pushImage(position, url, animation) {
  var frameSelector = "#photo-frame-"+position;
  $(frameSelector + " img").addClass("to-remove");
  $(frameSelector).append("<img class='animated "+ animation +"' src='"+url+"'>").
  one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', 
    function(){
      $(frameSelector + " .to-remove").remove();
    });
}
