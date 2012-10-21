# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/




$(document).on('mousedown', '.slot', ( (e)->


  start = document.elementFromPoint(e.pageX,e.pageY);

  $('#xStart').val(start.offsetLeft+2);
  $('#yStart').val(start.offsetTop+2);


  console.log("Click Position: "+e.pageX+"x"+e.pageY );
  console.log("Start Position: "+$('#xStart').val()+"x"+$('#yStart').val() );


));

$(document).on('mouseup', '.slot', ( (e)->
  $('#xEnd').val(e.pageX);
  $('#yEnd').val(e.pageY);

  console.log("End Position: "+$('#xEnd').val()+"x"+$('#yEnd').val() )

  start = document.elementFromPoint(e.pageX,e.pageY);

  h = (start.offsetTop-$('#yStart').val()) + 23;
  w = (start.offsetLeft-$('#xStart').val()) + 97;

  console.log("Trying to create a box with dimensions (x/y) "+w+"x"+h);
  console.log("Trying to create a box with start position (x/y) "+$('#xStart').val()+"x"+$('#yStart').val())

  lozenge = document.createElement('div');
  lozenge.id = h+"-"+w+"-"+$('#xStart').val()+"-"+$('#yStart').val();
  lozenge.style.height = h+"px";
  lozenge.style.width = w+"px";
  lozenge.style.left = $('#xStart').val()+"px";
  lozenge.style.top = $('#yStart').val()+"px";
  lozenge.className = "lozenge";
  lozenge.style.position = "absolute";


  xicon = document.createElement('img');

  xicon.src = "/assets/x.png";
  xicon.style.height = "10px";
  xicon.style.width = "10px";
  xicon.className = "close-x-icon";
  lozenge.appendChild(xicon);

  xicon.onclick = (() -> $("#"+lozenge.id).fadeOut('slow', () -> $("#"+lozenge.id).remove()); )


  $('#calendar').append(lozenge);
));
