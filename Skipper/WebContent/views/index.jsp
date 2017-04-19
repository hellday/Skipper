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
      <li><img src="../img/profil.png" alt="profil" width="25%"><br><a href="#">Navigateur 1</a></li>
      <li><img src="../img/profil.png" alt="profil" width="25%"><br><a href="#">Navigateur 2</a></li>
      <li><img src="../img/profil.png" alt="profil" width="25%"><br><a href="#">Navigateur 3</a></li>
      <li><img src="../img/profil.png" alt="profil" width="25%"><br><a href="#">Navigateur 4</a></li>
    </ul>
         
            </div>
            
            <div class="col-sm-6 text-center">
            <div class="Flexible-container">
                <div id="map" style="width:800px;height:800px;"></div>
            </div>
           	<br><br>
            <form>
            	<input id="textMessage" type="text">
            	<input onclick="sendMessage();" value="Send Message" type="button">
            </form>
            <br><textarea class="form-control" readonly id="messagesTextArea" rows="5"></textarea>
            </div>
            
            <div class="col-sm-3">
                <h1>Photo du navigateur et son navire.</h1>
                <p class="lead">Palmarès du navigateur sélectionné par un click (dans la liste à gauche).</p>            
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
            	alert("Opened!");
                messagesTextArea.value += "Server connected..." + "\n";
            }
            function onMessage(evt)  {
            	//document.getElementById("lab").innerHTML = evt.data ;
            	messagesTextArea.value += "Receive from server => " + evt.data + "\n";
            }
            function onError(evt) {
                afficher('<span style="color: red;">ERREUR:</span> ' + evt.data);
            }
            function envoyer() {
                websocket.send(donnesATransmettre);
            }
            function onClose(evt) {
            	alert("Closed!");
            	websocket.send("Client disconnected...");
            	messagesTextArea.value += "Server disconnected..." + "\n";
            }
            
            function sendMessage() {
            	if (textMessage.value == "close"){
            		websocket.close();
            	}else {
            		websocket.send(textMessage.value);
            		messagesTextArea.value += "Send to server => " + textMessage.value + "\n";
            		textMessage.value="";
            	}
            }

//window.addEventListener("load", ouvrir , false);
</script>
    
    <script>

// The following example creates a marker in Stockholm, Sweden using a DROP
// animation. Clicking on the marker will toggle the animation between a BOUNCE
// animation and no animation.

var marker;

function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 5,
    center: {lat: 48.85, lng: 2.31}
  });

  marker = new google.maps.Marker({
    map: map,
    draggable: false,
    animation: google.maps.Animation.DROP,
    title: 'Hello World!',
    position: {lat: 48.85, lng: 2.31}
  });
  marker.addListener('click', toggleBounce);
}

function toggleBounce() {
  if (marker.getAnimation() !== null) {
    marker.setAnimation(null);
  } else {
    marker.setAnimation(google.maps.Animation.BOUNCE);
  }
}

    </script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB27sQCoLX8b_sZn5PFBVMRqqGCxBcT8Hk&signed_in=true&callback=initMap"></script>


</body>
</html>