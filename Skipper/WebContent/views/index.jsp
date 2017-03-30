<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel=stylesheet type="text/css" href="../css/login.css">
<link href="../css/bootstrap.min.css" rel="stylesheet">

<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

<title>Skipper - Connexion</title>
</head>
<body>
<div class="container">
    <h1 class="welcome text-center">Skipper - Internautes</h1>
        <div class="card card-container">
        <h2 class='login_title text-center'>Login</h2>
        <hr>

            <form action="/action_page.php" method="post" class="form-signin">
                <span id="reauth-email" class="reauth-email"></span>
                <p class="input_title">Login</p>
                <input type="text" id="inputEmail" class="login_box" placeholder="" required autofocus>
                <p class="input_title">Mot de passe</p>
                <input type="password" id="inputPassword" class="login_box" placeholder="" required>
               
                <button class="btn btn-lg btn-primary" type="submit">Connexion</button>
            </form><!-- /form -->
        </div><!-- /card-container -->
    </div><!-- /container -->
</body>
</html>