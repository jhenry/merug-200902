// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
  // sets up the hover image for activity feed items  
  $(".imgHoverMarker").tooltip({
  showURL: false,
  bodyHandler: function() {
    var i = $(this).children()[0]
    var imgsrc = $(i).attr('src');
    return $('<img src="'+imgsrc+'" />');
  }
  });

  $('input,textarea').focus( function() {
  $(this).css('border-color', '#006699');
  });
  $('input,textarea').blur( function() {
  $(this).css('border-color','#ccc');
  });

  // facebox popups
  jQuery('a[rel*=facebox]').facebox();


initialize();

$("#attendance").click(function() {
    $("#attendance_form").toggle();
    var center = map.getCenter();
      map.checkResize();
      map.panTo(center);
      return false;
});

$("input#event_location, input#event_attendee_origin").blur(function() {
    showLocation($(this).val(), $(this).attr("id"));
    if ($(this).attr("id") == "event_attendee_origin") {
    var trip = new GDirections(map);
    GEvent.addListener(trip,"load", set_distance); 
    var query = "from: " + $("input#event_attendee_origin").val() + " to: " + $("#event_location").html();
    trip.load(query);
    
}
});

$("#example_address").click(function() {
    $("input#event_location").val($("#example_address").html());
    $("input#event_location").focus();
});

});

function set_distance (trip) {
    $("input#event_attendee_distance").val(trip.getDistance().meters);
}

var map;
    var geocoder;

    function initialize() {
      //map = new GMap2(document.getElementById("map_div"));
      //map.setCenter(new GLatLng(34, 0), 1);
      
      geocoder = new GClientGeocoder();
    }

    // addAddressToMap() is called when the geocoder returns an
    // answer.  It adds a marker to the map with an open info window
    // showing the nicely formatted version of the address and the country code.
    function addAddressToMap(response) {
      map.clearOverlays();
      if (!response || response.Status.code != 200) {
        //alert("Sorry, we were unable to geocode that address");
      } else {
          
        place = response.Placemark[0];
        $("input#event_location").val(place.address);
        point = new GLatLng(place.Point.coordinates[1],
                            place.Point.coordinates[0]);
                            
        map.setCenter (point);                    
         marker = new GMarker(point);
                 map.addOverlay(marker);
        //         marker.openInfoWindowHtml(place.address + '<br>' +
        //           '<b>Country code:</b> ' + place.AddressDetails.Country.CountryNameCode);
      }
    }

    // addAddressToMap() is called when the geocoder returns an
    // answer.  It adds a marker to the map with an open info window
    // showing the nicely formatted version of the address and the country code.
    function addAddressToMap2(response) {
      map.clearOverlays();
      if (!response || response.Status.code != 200) {
        //alert("Sorry, we were unable to geocode that address");
      } else {
          
        place = response.Placemark[0];
        $("input#event_attendee_origin").val(place.address);
        point = new GLatLng(place.Point.coordinates[1],
                            place.Point.coordinates[0]);
                            
        map.setCenter (point);                    
         marker = new GMarker(point);
                 map.addOverlay(marker);
                 
        //         marker.openInfoWindowHtml(place.address + '<br>' +
        //           '<b>Country code:</b> ' + place.AddressDetails.Country.CountryNameCode);
      }
    }

    // showLocation() is called when you click on the Search button
    // in the form.  It geocodes the address entered into the form
    // and adds a marker to the map at that location.
    function showLocation(address, form) {
      //var address = document.forms[0].q.value;
      if (form=="event_location") {
        geocoder.getLocations(address, addAddressToMap);
      } else {geocoder.getLocations(address, addAddressToMap2);}
       
    }

   // findLocation() is used to enter the sample addresses into the form.
    function findLocation(address) {
      document.forms[0].q.value = address;
      showLocation();
    }

    