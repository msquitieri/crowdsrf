$(function() {
	$('#locate-me-button').click(initLocation);

	$('#locate-map-button').click(function() {
		if (map) {
			var center = map.getCenter();
			var latitude = center.lat();
			var longitude = center.lng();

			setMarkerFromLatLng(map, center);
			getFoursquareInfo(latitude, longitude)
		}
	});

	// $('#intent').change(function () {
	// 	if ($(this).val() == "browse") $('#radius-holder').show();
	// 	else $('#radius-holder').hide();
	// });

	// $('#radius').keydown(function () {
	// 	setTimeout(function() {
	// 		var radius = $('#radius').val();

	// 		if (!/^[0-9]*$/.test(radius)) $('#locate-me').attr('disabled', "disabled");
	// 		else $('#locate-me').attr('disabled', "");
	// 	}, 100);
	// });

	// $('#locate-me').click();
	initLocation();
});

function initLocation() {
	if (navigator.geolocation)
		navigator.geolocation.getCurrentPosition(showPosition, showError);
	else alert("You don't have geolocation!");
}

function showPosition(position) {
	var latitude = position.coords.latitude;
	var longitude = position.coords.longitude;

	setMap(latitude, longitude);
	getFoursquareInfo(latitude, longitude);
}

var map;
var markers = [];
function setMap(latitude, longitude) {
	var $mapholder = $('#map-holder');
	
	var latlon = new google.maps.LatLng(latitude, longitude);

	var height = $(window).height();
	// console.log("height : " + height);
	$mapholder.css('height', height); //.css('width', '800px');
	//var mapholder = document.getElementById('mapholder');
	var options = {
		center : latlon,
		zoom : 17,
		mapTypeId : google.maps.MapTypeId.ROADMAP,
		mapTypeControl : false,
		navigationControlOptions : { style : google.maps.NavigationControlStyle.SMALL }
	};

	//var map = new google.maps.Map(document.getElementById('mapholder'), options);
	if (!map) map = new google.maps.Map($mapholder.get(0), options);

	map.setCenter(latlon);

	setMarkerFromLatLng(map, latlon);

	$mapholder.show();
	$("#map-button-holder").removeClass("hidden");
}

function clearMarkers() {
	for (var i=0; i<markers.length; i++)
		markers[i].setMap(null);
	markers.length = 0;
}
 
function setMarkerFromLocation(map, location) {
	var latlng = new google.maps.LatLng(location.lat, location.lng);
	var html = "<a class='marker-link' href='" + location.link + "'>"+location.name+"</a>";

	console.log("HTML = " + html);
	setMarkerFromLatLng(map, latlng, html);
}

function setMarkerFromLatLng(map, latlng, infoWindowContent) {
	var marker = new google.maps.Marker({
		position : latlng,
		map : map,
	});

	if (infoWindowContent) {
		console.log("making a new info window!");
		var infowindow = new google.maps.InfoWindow({
			content : infoWindowContent,
			maxWidth : 200
		});

		google.maps.event.addListener(marker, 'click', function() {
			console.log("clicked marker!");
			infowindow.open(map, marker);
		});
	}

	markers.push(marker);
}

function getFoursquareInfo(latitude, longitude) {
	var $venueList = $('#venue-list');
	$venueList.html("");

	$.ajax({
		url : '/locations.json',
		dataType : 'json',
		data : {
			location : {
				'lat' : latitude,
				'lng' : longitude
			}
		},
		success : function (data) {
			clearMarkers();

			console.log(data);
			if (data.code == 200) {
				var venues = data.response.venues;
				for (i=0; i<venues.length; i++) {
					console.log(venues[i]);
					var html = '<a href="'+venues[i].link+'" class="list-group-item">'
							+  venues[i].name;
					if (venues[i].photos && venues[i].photos.length > 0)
						html += '<span class="badge">' + venues[i].photos.length + '</span>';

					setMarkerFromLocation(map, venues[i]);

					// $venueList.append('<tr><td>' + venues[i].name + '</td><td><button id="' + venues[i].id + '" class="media-button">Generate</button></td></tr>');
					// $venueList.append('<li><a data-transition="slide" href="./images.php?foursquare_id=' + venues[i].id + '">' + venues[i].name + '</a></li>');
					$venueList.append(html);
				}

				// $foursquare.listview('refresh').show();
			} else alert("ERROR!\n\n" + "Error Code: " + data.meta.code + "\nError Detail: " + data.meta.errorDetail);
		},
		error : function(xhr, status, err) { 
			console.log("IN ERROR!!");
		}
	});
}

function showError(error) {
	switch(error.code) {
		case error.PERMISSION_DENIED:
			alert("User denied the request for Geolocation.");
			break;
		case error.POSITION_UNAVAILABLE:
			alert("Location information is unavailable.");
			break;
		case error.TIMEOUT:
			alert("The request to get user location timed out.");
			break;
		case error.UNKNOWN_ERROR:
			alert("An unknown error occurred.");
			break;
	}
}
