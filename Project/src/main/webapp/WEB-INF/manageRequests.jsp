<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Requests - ShipEase Logistic Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
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
            text-align: center;
        }

        .container {
            width: 100%;
            padding: 2em;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h3 {
            color: #333;
            margin-bottom: 20px;
        }

        form {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 14px;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"], input[type="password"], select {
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: calc(100% - 22px);
            margin-bottom: 10px;
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: #2C6E8F;
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

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
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

        .action-form {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .action-form select, .action-form input[type="submit"] {
            margin-left: 5px;
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
        <h1>Manage Requests</h1>
        <div class="container">
            <h3>Pending and Allocated Requests</h3>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Sender Name</th>
                    <th>Pickup Address</th>
                    <th>Package Name</th>
                    <th>Recipient Name</th>
                    <th>Recipient Address</th>
                    <th>Phone Number</th>
                    <th>Status</th>
                    <th>Allocated Rider</th>
                    <th>Allocate Rider</th>
                    <th>Update Status</th>
                </tr>
                <c:forEach var="request" items="${requests}">
                    <c:if test="${request.status != 'Completed'}">
                        <tr>
                            <td>${request.id}</td>
                            <td>${request.senderName}</td>
                            <td>${request.pickupAddress}</td>
                            <td>${request.packageName}</td>
                            <td>${request.recipientName}</td>
                            <td>${request.recipientAddress}</td>
                            <td>${request.phoneNumber}</td>
                            <td>${request.status}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${request.rider != null}">
                                        ${request.rider.username}
                                    </c:when>
                                    <c:otherwise>
                                        Not allocated
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <form action="/admin/allocate" method="post" class="action-form">
                                    <input type="hidden" name="requestId" value="${request.id}">
                                    <select name="riderId" required>
                                        <option value="">Select Rider</option>
                                        <c:forEach var="rider" items="${riders}">
                                            <option value="${rider.id}">${rider.username}</option>
                                        </c:forEach>
                                    </select>
                                    <input type="submit" value="Allocate">
                                </form>
                            </td>
                            <td>
                                <form action="/admin/updateStatus" method="post" class="action-form">
                                    <input type="hidden" name="requestId" value="${request.id}">
                                    <select name="status" required>
                                        <option value="Pending" ${request.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                        <option value="Allocated" ${request.status == 'Allocated' ? 'selected' : ''}>Allocated</option>
                                        <option value="Completed" ${request.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                    </select>
                                    <input type="submit" value="Update Status">
                                </form>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>

            <h3>Completed Requests</h3>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Sender Name</th>
                    <th>Pickup Address</th>
                    <th>Package Name</th>
                    <th>Recipient Name</th>
                    <th>Recipient Address</th>
                    <th>Phone Number</th>
                    <th>Status</th>
                </tr>
                <c:forEach var="request" items="${requests}">
                    <c:if test="${request.status == 'Completed'}">
                        <tr>
                            <td>${request.id}</td>
                            <td>${request.senderName}</td>
                            <td>${request.pickupAddress}</td>
                            <td>${request.packageName}</td>
                            <td>${request.recipientName}</td>
                            <td>${request.recipientAddress}</td>
                            <td>${request.phoneNumber}</td>
                            <td>${request.status}</td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
        </div>
    </div>
</body>
</html>
