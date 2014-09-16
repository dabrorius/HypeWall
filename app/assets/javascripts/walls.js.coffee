# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # Tool box
  #
  # add data-tool-box="toolbox-name" to tool box
  # add data-tool-box-open="toolbox-name" to open button
  # add data-tool-box-close="toolbox-name" to closing toolbox
  # toolbox-name must match
  #
  $('[data-tool-box-open]').click ->
    target = $(this).data "tool-box-open"
    $(this).addClass "hide"
    $("[data-tool-box='#{target}']").removeClass "hide"

  $('[data-tool-box-close]').click ->
    target = $(this).data "tool-box-close"
    $("[data-tool-box='#{target}']").addClass "hide"
    $("[data-tool-box-open='#{target}']").removeClass "hide"


  doFirstFadeOut = true
  setTimeout ->
    if doFirstFadeOut
      $("#wall-menu").fadeOut()
  , 4000

  $("#wall-menu-trigger").hover ->
      doFirstFadeOut = false
      $("#wall-menu").show()
    , ->
      $("#wall-menu").fadeOut()

  $(".fullscreen").click ->
    element = document.documentElement
    if element.requestFullscreen
      element.requestFullscreen()
    else if element.mozRequestFullScreen
      element.mozRequestFullScreen()
    else if element.webkitRequestFullscreen
      element.webkitRequestFullscreen()
    else if element.msRequestFullscreen
      element.msRequestFullscreen()

  $('.colorpicker').minicolors theme: 'bootstrap'

  centerDescription = ->
    container = $('#info');
    content = $('#description');
    content.css("top", (container.height()-content.height())/2);

  centerDescription()
  $(".logo").load ->
    centerDescription()
  window.onresize = centerDescription