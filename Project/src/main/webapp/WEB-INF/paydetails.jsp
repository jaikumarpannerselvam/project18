<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Details - ShipEase Logistic Management</title>
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

        .container {
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #3B8A7F;
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #3B8A7F;
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        button {
            padding: 10px 20px;
            background-color: #3B8A7F;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        button:hover {
            background-color: #2C6E8F;
        }

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

            table, th, td {
                font-size: 14px;
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
        

        <div class="container">
            <h2>All Payment Details</h2>
            <table>
                <thead>
                    <tr>
                        <th>Request ID</th>
                        <th>Card Number</th>
                        <th>Card Holder Name</th>
                        <th>CVV</th>
                        <th>Expiry Date</th>
                        <th>Amount</th>
                        <th>Sender ID</th>
                        <th>Sender Name</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="payment" items="${paymentDetails}">
                        <tr>
                            <td>${payment.requestId}</td>
                            <td>${payment.cardNumber}</td>
                            <td>${payment.cardHolderName}</td>
                            <td>${payment.cvv}</td>
                            <td>${payment.expiryDate}</td>
                            <td>${payment.amount}</td>
                            <td>${payment.sender.id}</td>
                            <td>${payment.sender.username}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <form action="/admin/downloadPayments" method="get">
                <button type="submit">Download All Payments as PDF</button>
            </form>
        </div>
    </div>
</body>
</html>
