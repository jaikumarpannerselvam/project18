<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Riders - ShipEase Logistic Management</title>
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
            margin-left: 280px;
            padding: 40px;
        }

        .main-content h2 {
            font-size: 28px;
            color: #3B8A7F;
            margin-bottom: 20px;
        }

        /* Form styling */
        form {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 14px;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"], input[type="password"] {
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 50%;
            margin-bottom: 10px;
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: #2C6E8F; /* Changed to match navbar */
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #3B8A7F;
        }

        /* Table Styling */
        table {
            width: 70%;
            margin-top: 20px;
            border-collapse: collapse;
            font-size: 14px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #3B8A7F;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        /* Form inside table cells */
        .action-form {
            display: inline-block;
            margin-right: 10px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
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
    <a href="/">Home</a>
        <a href="">About Us</a>
        <a href="">Services</a>
        <a href="">Contact</a>
    </nav>

    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <h2><u>Admin Panel</u></h2>
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
    <div class="main-content">
        <h2>Manage Riders</h2>
        <!-- Form to add a new rider -->
        <form action="/admin/addRider" method="post">
            <label for="riderUsername">Username:</label>
            <input type="text" id="riderUsername" name="username" required>
            <label for="riderPassword">Password:</label>
            <input type="password" id="riderPassword" name="password" required>
            <input type="submit" value="Add Rider">
        </form>

        <!-- Table to display existing riders -->
        <h3>Existing Riders</h3>
        <table>
            <tr>
                <th>ID</th>
                <th>Username</th>

            </tr>
            <c:forEach var="rider" items="${riders}">
                <tr>
                    <td>${rider.id}</td>
                    <td>${rider.username}</td>
                    <td>
                        <!-- Form to update rider details -->
                        <form action="/admin/removeRider" method="post" class="action-form">
                            <input type="hidden" name="riderId" value="${rider.id}">
                            <input type="submit" value="Remove">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
