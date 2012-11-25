// '2012/11/25 23:00:00'
$(function() {
  $('div#clock').countdown('2012/11/25 23:00:00', function(event) {
    $this = $(this);
    switch(event.type) {
      case "seconds":
      case "minutes":
      case "hours":
      case "days":
      case "weeks":
      case "daysLeft":
        $this.find('span#'+event.type).html(event.value);
        break;
      case "finished":
        $('#info_pannel').fadeOut(1000);
        $('#launch_pannel').fadeIn(1600);
        $('#center_curtain').animate({ top: '-100%' }, 1600);
        setTimeout('window.location = \'/\'', ((Math.floor(Math.random()*23))*1000)+3000);
        break;
    }
  });
});