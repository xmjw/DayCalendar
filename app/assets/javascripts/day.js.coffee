# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/




$(document).on('mousedown', '.control-slot', ( (e)->


  start = document.elementFromPoint(e.pageX,e.pageY);

  $('#xStart').val(start.offsetLeft+2);
  $('#yStart').val(start.offsetTop+2);


  console.log("Click Position: "+e.pageX+"x"+e.pageY );
  console.log("Start Position: "+$('#xStart').val()+"x"+$('#yStart').val() );


));


processData = (d, textStatus, jqXHR) ->
  script = $(d).text();
  alert (script);
  exec(script);
  console.log("Processed AJAX response.");
  false;

failedData = (d) ->
  alert(d)

$(document).on('mouseup', '.control-slot', ( (e)->
  $('#xEnd').val(e.pageX);
  $('#yEnd').val(e.pageY);

  console.log("End Position: "+$('#xEnd').val()+"x"+$('#yEnd').val() )

  start = document.elementFromPoint(e.pageX,e.pageY);

  h = (start.offsetTop-$('#yStart').val()) + 23;
  w = (start.offsetLeft-$('#xStart').val()) + 97;

  console.log("Making Ajax Request")

  $.post('/day/entry.js', {h: h, w: w, l: $('#xStart').val(), t: $('#yStart').val()}, success: processData, error: failedData );

  console.log("Finished trying to do AJAXy Sugar")
));

$(document).ready(() ->
  $(".control-slot").each(() ->
    slot = $("#"+$(this).attr("id")+"x")

    $(this).css({
      "left": slot.position().left
      "top": slot.position().top
      "position": "absolute"
      "width": "100"
      "display": "block"
    });
  )
);

