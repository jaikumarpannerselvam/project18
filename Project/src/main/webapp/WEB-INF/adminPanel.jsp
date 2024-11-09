<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Page Title - ShipEase Logistic Management</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f9f9f9;
	color: #333;
}

/* Navigation Bar */
nav {
	background-color: #2C6E8F;
	overflow: hidden;
}

nav a {
	float: left;
	display: block;
	color: white;
	text-align: center;
	padding: 14px 20px;
	text-decoration: none;
	font-size: 18px;
}

nav a:hover {
	background-color: #3B8A7F;
	color: white;
}

/* Header with ShipEase Logistic Management */
header {
	background-color: #3B8A7F;
	color: white;
	padding: 20px;
	text-align: center;
}

header h1 {
	margin: 0;
	font-size: 28px;
}

/* Sidebar */
.sidebar {
	background-color: #3B8A7F;
	width: 250px;
	height: 100vh;
	position: fixed;
	padding: 20px;
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
}

.sidebar h2 {
	color: #fff;
	text-align: center;
	font-size: 24px;
	margin-bottom: 40px;
}

.sidebar ul {
	list-style: none;
	padding: 0;
}

.sidebar ul li {
	margin-bottom: 20px;
}

.sidebar ul li a {
	color: #fff;
	text-decoration: none;
	font-size: 18px;
	display: block;
	padding: 10px;
	border-radius: 4px;
	transition: background-color 0.3s;
}

.sidebar ul li a:hover {
	background-color: #35766D;
}

/* Main Content */
.main-content {
	width: 78%;
	margin-left: 270px;
	height:70vh;
	/* Increased margin to create more space from the sidebar */
	padding: 40px;
	text-align: center;
	background-image: url(/image/logisticsss.jpeg);
	background-repeat: no-repeat;
	background-size: cover;
	/* Align image to the center */
}

/* Add ship/airplane image */
.main-content img {
	max-width: 100%;
	height: auto;
	display: inline-block; /* Keep the image inline and centered */
	margin: 0 auto;
}

/* Buttons */
input[type="submit"] {
	padding: 10px 20px;
	background-color: #28a745;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s;
}

input[type="submit"]:hover {
	background-color: #218838;
}

/* Responsive */
@media ( max-width : 768px) {
	.sidebar {
		width: 100%;
		height: auto;
		position: relative;
	}
	.sidebar ul {
		display: flex;
		justify-content: space-around;
	}
	.main-content {
		margin-left: 0;
	}
}
</style>
</head>
<body>

	<!-- Navigation Bar -->
	<nav>
		<a href="/">Home</a> <a href="">About Us</a> <a href="">Services</a> <a
			href="">Contact</a>
	</nav>

	<!-- Header with title -->
	<header>
		<h1>ShipEase Logistic Management</h1>
	</header>

	<!-- Sidebar Navigation -->
	<div class="sidebar">
		<h2>
			<u>Admin Panel</u>
		</h2>
		<ul>
			<li><a href="/admin/panel">Dashboard</a></li>
			<li><a href="/admin/manageRiders">Manage Riders</a></li>
			<li><a href="/admin/manageRequests">Manage Requests</a></li>
			<li><a href="/admin/paydetails">Payment Details</a></li>
			<li><a href="/admin/viewTickets">View Tickets</a></li>
			<li><a href="/admin/logout">Logout</a></li>
		</ul>
	</div>

	<!-- Main Content -->
	<div class="main-content"></div>

</body>
</html>
