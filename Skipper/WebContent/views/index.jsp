<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Skipper</title>

    <!-- Bootstrap Core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../css/googlemap.css" rel="stylesheet">
   
    
    <style>
    body {
        padding-top: 70px;
        /* Required padding for .navbar-fixed-top. Remove if using .navbar-static-top. Change if height of navigation changes. */
    }
    </style>
    
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 500px;
        width: 500px;
      }
      
      #floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }
    </style>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    

</head>

<body>

    <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Skipper</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Page Content -->
    <div class="container">

        <div class="row">
            <div class="col-sm-3">
                <h1>Liste des navigateurs</h1>
                
    <ul data-role="listview">
      <li><a href="#" id="nav1">Terry Grosso</a></li><br>
      <li><a href="#" id="nav2">Nicolas Olivier</a></li><br>
      <li><a href="#" id="nav3">Moaz Chaudry</a></li><br>
      <li><a href="#" id="nav4">Jean Clémenceau</a></li>
    </ul>
         
            </div>
            
            <div class="col-sm-6 text-center">
            	<div id="floating-panel">
			     
			      <input onclick="showMarkers();" type=button value="Afficher tous les navigateurs">
			      
			    </div>
                <div id="map"></div>
            
           	<br><br>
           <!--   <form>
            	<input id="textMessage" type="text">
            	<input onclick="sendMessage();" value="Send Message" type="button">
            </form> -->
            <br><textarea class="form-control" readonly id="messagesTextArea" rows="5"></textarea>
            </div>
            
            <div class="col-sm-3">
                <h1>Photo du navigateur et son navire :</h1>
                <p class="lead"><img src="../img/profil.png" alt="profil" width="25%"></p>            
            </div>
        </div>
        <!-- /.row -->

    </div>
    <!-- /.container -->
    
    

    <!-- jQuery Version 1.11.1 -->
    <script src="../js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../js/bootstrap.min.js"></script>
    
    <script language="javascript" type="text/javascript">
    
    
    
    
///Script du WebSocket
var messagesTextArea = document.getElementById("messagesTextArea");
var nav;
var poly;
var path;

document.getElementById("nav1").onclick = function(){getLocations(1);}
document.getElementById("nav2").onclick = function(){getLocations(2);}
document.getElementById("nav3").onclick = function(){getLocations(3);}
document.getElementById("nav4").onclick = function(){getLocations(4);}

function getRootUri() {
                return "ws://" + (document.location.hostname == "" ?
                    "localhost" : document.location.hostname) + ":" +
                    (document.location.port == "" ? "8080" : document.location.port);
            }

                var wsUri = getRootUri() + "/Skipper/echo";
                websocket = new WebSocket(wsUri);
           
                websocket.onopen = function(evt) {
                    onOpen(evt)
                };
                websocket.onclose = function(evt) {
                    onClose(evt)
                };
                websocket.onmessage = function(evt) {
                    onMessage(evt)
                };
                websocket.onerror = function(evt) {
                    onError(evt)
                };
            
            
            function onOpen(evt) {
                messagesTextArea.value += "Server connected..." + "\n";
            }
            function onMessage(evt)  {
            	messagesTextArea.value += "Receive from server => " + evt.data + "\n from idNav => " + nav + "\n";
            	
            	deleteMarkers(); //Clean la map
            	
            	// Récupération des coordonnées & Création des marqueurs sur la map
            	var array = evt.data.split('%');
            	var arrayLength = array.length;
            	
         
            	// Ajout des marqueurs
            	for (var i = 0; i < arrayLength; i++) {
            		          		
            	    var latlng = getLatLngFromString(array[i])
            	    
            	    if(i == arrayLength-1){
            	    	addMarker(latlng, nav, true); 
            	    }else {
            	    	addMarker(latlng, nav, false); 
            	    }
            	}
            	
            	
            	
            	
            	
            	
            }
            function onError(evt) {
                afficher('<span style="color: red;">ERREUR:</span> ' + evt.data);
            }
            function envoyer() {
                websocket.send(donnesATransmettre);
            }
            function onClose(evt) {
            	alert("Serveur déconnecté");
            	websocket.send("Client disconnected...");
            	messagesTextArea.value += "Server disconnected..." + "\n";
            }
            
            function sendMessage() {
            	if (textMessage.value == "close"){
            		websocket.close();
            	}else {
            		websocket.send(textMessage.value);
            		messagesTextArea.value += "Send to server => " + textMessage.value + "\n";
            		nav = textMessage.value;
            		textMessage.value="";
            	}
            }
            
            function getLatLngFromString(ll) {
                var latlng = ll.split(/, ?/)
                return new google.maps.LatLng(parseFloat(latlng[0]), parseFloat(latlng[1])); 
            }
            
            function getLocations(idnav) {
            	nav = idnav;
                websocket.send(idnav);
            }

//window.addEventListener("load", ouvrir , false);



 // The following example creates a marker in Stockholm, Sweden using a DROP
 // animation. Clicking on the marker will toggle the animation between a BOUNCE
 // animation and no animation.

 var map;
 var marker;
 var markers = [];


 function initMap() {
   map = new google.maps.Map(document.getElementById('map'), {
     zoom: 8,
     center: {lat: 47.795973, lng: -4.375638}
   });

   var latlng = new google.maps.LatLng(47.795973, -4.375638);
   
// Création de la route entre les points
	poly = new google.maps.Polyline({
     strokeColor: '#000000',
     strokeOpacity: 1.0,
     strokeWeight: 3
   });
   poly.setMap(map);
   path = poly.getPath();
   
   
   showMarkers();
 }

 //Adds a marker to the map and push to the array.
 function addMarker(location, idNav, isLast) {
	 if(idNav == 1 & isLast){
	   var marker = new google.maps.Marker({
	     position: location,
	     draggable: false,
	     icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png',
	     map: map
	   });
	   markers.push(marker);
	 }else if(idNav == 1){
		 var marker = new google.maps.Marker({
		     position: location,
		     draggable: false,
		     icon: 'http://maps.google.com/mapfiles/ms/icons/blue-pushpin.png',
		     map: map
		   });
		 markers.push(marker);
	 }
	 
	 if(idNav == 2 & isLast){
		   var marker = new google.maps.Marker({
		     position: location,
		     draggable: false,
		     icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
		     map: map
		   });
		   markers.push(marker);
		 }else if(idNav == 2){
			 var marker = new google.maps.Marker({
			     position: location,
			     draggable: false,
			     icon: 'http://maps.google.com/mapfiles/ms/icons/grn-pushpin.png',
			     map: map
			   });
			   markers.push(marker);
		 }
	 
	 if(idNav == 3 & isLast){
		   var marker = new google.maps.Marker({
		     position: location,
		     draggable: false,
		     icon: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png',
		     map: map
		   });
		   markers.push(marker);
		 }else if(idNav == 3){
			 var marker = new google.maps.Marker({
			     position: location,
			     draggable: false,
			     icon: 'http://maps.google.com/mapfiles/ms/icons/red-pushpin.png',
			     map: map
			   });
			   markers.push(marker);
		 }
	 
	 if(idNav == 4 & isLast){
		   var marker = new google.maps.Marker({
		     position: location,
		     draggable: false,
		     icon: 'http://maps.google.com/mapfiles/ms/icons/yellow-dot.png',
		     map: map
		   });
		   markers.push(marker);
		 }else if(idNav == 4){
			 var marker = new google.maps.Marker({
			     position: location,
			     draggable: false,
			     icon: 'http://maps.google.com/mapfiles/ms/icons/ylw-pushpin.png',
			     map: map
			   });
			   markers.push(marker);
		 }
	 
	 
	 path.push(location)
 }

 //Sets the map on all markers in the array.
 function setMapOnAll(map) {
   for (var i = 0; i < markers.length; i++) {
     markers[i].setMap(map);
   }
 }

 //Removes the markers from the map, but keeps them in the array.
 function clearMarkers() {
   setMapOnAll(null);
 }

 // Shows any markers currently in the array.
 function showMarkers() {
   setMapOnAll(map);
 }

  // Deletes all markers in the array by removing references to them.
       function deleteMarkers() {
         clearMarkers();
         markers = [];
         path.clear();
       }

 function toggleBounce() {
   if (marker.getAnimation() !== null) {
     marker.setAnimation(null);
   } else {
     marker.setAnimation(google.maps.Animation.BOUNCE);
   }
 }

 function myFunction() {
 	marker.setIcon('http://maps.google.com/mapfiles/ms/icons/blue-dot.png')
 }

 function clearMap() {
 	map.clear()
 }


    </script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB27sQCoLX8b_sZn5PFBVMRqqGCxBcT8Hk&signed_in=true&callback=initMap"></script>


</body>
</html>