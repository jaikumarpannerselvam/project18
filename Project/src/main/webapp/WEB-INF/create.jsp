<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Sender Request - ShipEase Logistics Management</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
        }

        /* Header */
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
            margin-left: 270px; /* Adjusted to fit sidebar */
            padding: 40px;
        }

        .main-content h2 {
            font-size: 28px;
            color: #3B8A7F;
            margin-bottom: 20px;
        }

        /* Form styling */
        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 0.5em;
            font-weight: bold;
            color: #333;
        }

        input[type="text"], input[type="datetime-local"], input[type="number"] {
            margin-bottom: 1em;
            padding: 0.5em; /* Reduced padding */
            font-size: 0.9em; /* Reduced font size */
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 90%; /* Reduced width */
            max-width: 600px; /* Added max-width */
        }


input[type="submit"] {
    padding: 0.5em; /* Reduced padding */
    font-size: 0.9em; /* Reduced font size */
    color: #fff;
    background: navy; /* Navy blue color */
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-top: 1em;
    width: auto; /* Adjust width to fit content */
    max-width: 600px; /* Set a maximum width if desired */
}
        input[type="submit"]:hover {
            background: darkblue; /* Darker shade of navy blue for hover effect */
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
 <nav>
      <a href="/">Home</a>
        <a href="">About Us</a>
        <a href="">Services</a>
        <a href="">Contact</a>
    </nav>

    <!-- Header -->
    <header>
        <h1>ShipEase Logistics Management - Create Request</h1>
    </header>

    <!-- Navigation Bar -->
    

    <!-- Sidebar -->
    <div class="sidebar">
        <h2><u>User Panel</u></h2>
        <ul>
            <li><a href="/sender/status?senderUsername=${senderUsername}">View Status</a></li>
            <li><a href="/sender/deliveries">Your Deliveries</a></li>
            <li><a href="/sender/create">Create Request</a></li>
            <li><a href="/logout">Logout</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h2>Create Sender Request</h2>
        <form action="/sender/submit" method="post">
            <label for="senderName">Sender Name:</label>
            <input type="text" id="senderName" name="senderName" required>
            <label for="pickupAddress">Pickup Address:</label>
            <input type="text" id="pickupAddress" name="pickupAddress" required>
            <label for="packageName">Package Name:</label>
            <input type="text" id="packageName" name="packageName" required>
            <label for="recipientName">Recipient Name:</label>
            <input type="text" id="recipientName" name="recipientName" required>
            <label for="recipientAddress">Recipient Address:</label>
            <input type="text" id="recipientAddress" name="recipientAddress" required>
            <label for="phoneNumber">Phone Number:</label>
            <input type="text" id="phoneNumber" name="phoneNumber" required>
            <label for="description">Description:</label>
            <input type="text" id="description" name="description">
            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" min="1" required>
            <label for="expectedDelivery">Expected Delivery (optional):</label>
            <input type="datetime-local" id="expectedDelivery" name="expectedDelivery">
            <input type="submit" value="Submit">
        </form>
    </div>

</body>
</html>
