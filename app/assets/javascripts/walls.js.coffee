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