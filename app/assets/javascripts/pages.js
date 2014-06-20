function animatePhoto(photoId, animation) {
  $("#photo-frame-"+photoId).removeClass().addClass('photo-frame animated ' + animation).one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
    $(this).removeClass().addClass("photo-frame");
  });
}

