<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Deliveries - ShipEase Logistic Management</title>
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

        .main-content h1 {
            font-size: 28px;
            color: #3B8A7F;
            margin-bottom: 20px;
        }

        /* Table Styling */
        table {
            width: 100%;
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

        .contact-support {
            background-color: #FF6F61; /* Red-orange color */
            color: white;
            text-align: center;
            padding: 8px;
            border-radius: 4px;
        }

        a {
            color: #3B8A7F;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
            color: #2C6E8F;
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
        <h1>Your Deliveries</h1>
        <table>
            <tr>
                <th>Request ID</th>
                <th>Sender Name</th>
                <th>Sender ID</th>
                <th>Pickup Address</th>
                <th>Package Name</th>
                <th>Recipient Name</th>
                <th>Recipient Address</th>
                <th>Phone Number</th>
                <th>Status</th>
                <th>Contact Support</th>
            </tr>
            <c:forEach var="request" items="${completedRequests}">
                <tr>
                    <td>${request.id}</td>
                    <td>${request.senderName}</td>
                    <td>${senderId}</td>
                    <td>${request.pickupAddress}</td>
                    <td>${request.packageName}</td>
                    <td>${request.recipientName}</td>
                    <td>${request.recipientAddress}</td>
                    <td>${request.phoneNumber}</td>
                    <td>${request.status}</td>
                    <td class="contact-support"><a href="${pageContext.request.contextPath}/sender/contactSupport?requestId=${request.id}&senderId=${senderId}">Contact Support</a></td>
                </tr>
            </c:forEach>
        </table>
    </div>

</body>
</html>
