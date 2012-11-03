# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


processData = (d, textStatus, jqXHR) ->
  script = $(d).text();
  alert (script);
  exec(script);
  console.log("Processed AJAX response.");
  false;

failedData = (d) ->
  alert(d)

onDown = ( (e)->
  start = $(document.elementFromPoint(e.pageX,e.pageY));

  if ($(start).hasClass('lozenge'))
    start = $(start).parent();

  console.log("Click start was on: "+$(start).attr('id'));
  $('#xStart').val($(start).attr('id'))
  false
)

onUp = ( (e)->
  end = document.elementFromPoint(e.pageX,e.pageY);

  if ($(end).hasClass('lozenge'))
    end = $(end).parent()

  start = $('#xStart').val()
  console.log("Click end was on: "+$(end).attr('id'));
  $.post('/day/entry.js', {s: start, e: $(end).attr('id')}, success: processData, error: failedData );
  false
)

$(document).on('mousedown', '.slot', onDown);
$(document).on('touchstart', '.slot', onDown);

$(document).on('mouseup', '.slot', onUp);
$(document).on('touchend', '.slot', onUp);

