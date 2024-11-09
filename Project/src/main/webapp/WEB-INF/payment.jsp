<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Page - ShipEase Logistic Management</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
        }
        .container {
            width: 50%;
            margin: auto;
            padding: 20px;
            background: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #3B8A7F; /* Match main header color */
        }
        p {
            font-size: 16px;
            margin-bottom: 10px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group button {
            width: 100%;
            padding: 10px;
            background: #2C6E8F; /* Match button color to main navbar color */
            border: none;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-group button:hover {
            background: #3B8A7F; /* Match button hover color */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Payment for Request #${request.id}</h1>
        <p>Amount to Pay: $${request.amount}</p> <!-- Display the dynamic amount -->

        <!-- Modify form action to redirect to /paymentDetails -->
        <form action="/sender/paymentDetails" method="get">
            <input type="hidden" name="requestId" value="${request.id}">
            <input type="hidden" name="amount" value="${request.amount}"> <!-- Pass amount as hidden field -->
            <input type="hidden" name="senderId" value="${request.sender.id}"> <!-- Pass senderId -->
            <input type="hidden" name="senderName" value="${request.sender.username}"> <!-- Pass senderName -->
            <button type="submit">Confirm Payment</button>
        </form>
    </div>
</body>
</html>
