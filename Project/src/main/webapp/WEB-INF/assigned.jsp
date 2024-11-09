<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assigned Requests - ShipEase Logistic Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
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
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #3B8A7F;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        form {
            margin: 0;
        }

        select {
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input[type="submit"] {
            padding: 5px 10px;
            background-color: #2C6E8F;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 5px;
        }

        input[type="submit"]:hover {
            background-color: #3B8A7F;
        }

        /* Responsive Design */
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

    <!-- Navigation Bar -->
    <nav>
       
       
       
    </nav>

    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <h2><u>Rider Panel</u></h2>
        <ul>
            <li> <a href="/rider/assigned?riderId=${riderId}">Assigned Requests</a></li>
            <li> <a href="/rider/completedRequests?riderId=${riderId}">Completed Requests</a></li>
            <li> <a href="/rider/logout">Logout</a></li>
        </ul>
    </div>
    <!-- Main Content -->
    <div class="main-content">
        <h1>Assigned Requests</h1>

        <!-- Rider ID validation section -->
        <c:if test="${not empty riderId}">
            <p>Rider ID: ${riderId}</p>
        </c:if>
        <c:if test="${empty riderId}">
            <p style="color:red;">Rider ID is missing!</p>
        </c:if>

        <table>
            <thead>
                <tr>
                    <th>Sender Name</th>
                    <th>Pickup Address</th>
                    <th>Package Name</th>
                    <th>Recipient Name</th>
                    <th>Recipient Address</th>
                    <th>Phone Number</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="request" items="${requests}">
                    <tr>
                        <td>${request.senderName}</td>
                        <td>${request.pickupAddress}</td>
                        <td>${request.packageName}</td>
                        <td>${request.recipientName}</td>
                        <td>${request.recipientAddress}</td>
                        <td>${request.phoneNumber}</td>
                        <td>${request.status}</td>
                        <td>
                            <form action="/rider/updateStatus" method="post">
                                <input type="hidden" name="requestId" value="${request.id}">
                                <input type="hidden" name="riderId" value="${riderId}">
                                <select name="status">
                                    <option value="On Transit" ${request.status == 'On Transit' ? 'selected' : ''}>On Transit</option>
                                    <option value="Picked Up" ${request.status == 'Picked Up' ? 'selected' : ''}>Picked Up</option>
                                    <option value="Delivered" ${request.status == 'Delivered' ? 'selected' : ''}>Delivered</option>
                                </select>
                                <input type="submit" value="Update Status">
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
