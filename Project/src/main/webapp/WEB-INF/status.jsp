<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Status - ShipEase Logistic Management</title>
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
            text-align: center;
            margin-bottom: 20px;
        }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        th, td {
            padding: 0.75em;
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .sidebar ul {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-around;
            }

            .main-content {
                margin-left: 0;
                padding: 20px;
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
        <h1>Request Status</h1>
        <table>
            <tr>
                <th>Request ID</th> <!-- New Column for Request ID -->
                <th>Sender Name</th>
                <th>Pickup Address</th>
                <th>Package Name</th>
                <th>Recipient Name</th>
                <th>Recipient Address</th>
                <th>Phone Number</th>
                <th>Status</th>
                <th>Allocated Rider</th> <!-- New Column for Rider Name -->
            </tr>

            <!-- Iterate over requests and only show those that are not "Completed" -->
            <c:forEach var="request" items="${requests}">
                <c:if test="${request.status != 'Completed'}">
                    <tr>
                        <td>${request.id}</td> <!-- Display Request ID -->
                        <td>${request.senderName}</td>
                        <td>${request.pickupAddress}</td>
                        <td>${request.packageName}</td>
                        <td>${request.recipientName}</td>
                        <td>${request.recipientAddress}</td>
                        <td>${request.phoneNumber}</td>
                        <td>${request.status}</td>
                        <!-- Show allocated rider's name if available -->
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
                    </tr>
                </c:if>
            </c:forEach>
        </table>
    </div>
</body>
</html>
