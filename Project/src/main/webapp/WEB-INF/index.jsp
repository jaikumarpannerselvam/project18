<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - ShipEase Logistic Management</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9; /* Updated to match other pages */
            color: #333;
        }
        
        /* Navigation Bar */
        nav {
            background-color: #2C6E8F; /* Updated color to match the sidebar */
            color: white;
            padding: 1em 0;
        }

        nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
            text-align: center;
        }

        nav ul li {
            display: inline;
            margin-right: 20px;
        }

        nav ul li a {
            color: #fff;
            text-decoration: none;
            padding: 0.5em;
        }

        nav ul li a.active {
            background-color: #3B8A7F; /* Updated color for active tab */
            border-radius: 4px;
        }

        /* Main Content */
        .main-content {
            padding: 2em;
            text-align: center; /* Centered content */
        }

        h1 {
            color: #333;
        }

        p {
            font-size: 18px;
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <nav>
        <div class="container">
            <ul>
                <li><a href="/" class="active">Home</a></li>
                <li><a href="/login">Login</a></li>
                <li><a href="/register">Register</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <h1>Welcome to ShipEase Logistic Management</h1>
        <p>Your one-stop solution for managing logistics efficiently.</p>
    </div>

</body>
</html>
