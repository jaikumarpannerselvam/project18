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
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
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
        <h1>Enter Payment Details for Request #${requestId}</h1>
        <p>Amount: $${param.amount}</p> <!-- Display the amount -->
        <p>Sender ID: ${param.senderId}</p> <!-- Display senderId -->
        <p>Sender Name: ${param.senderName}</p> <!-- Display senderName -->

        <form action="/sender/savePaymentDetails" method="post">
            <input type="hidden" name="requestId" value="${requestId}">
            <input type="hidden" name="amount" value="${param.amount}"> <!-- Pass amount to be saved -->
            <input type="hidden" name="senderId" value="${param.senderId}"> <!-- Pass senderId to be saved -->
            <input type="hidden" name="senderName" value="${param.senderName}"> <!-- Pass senderName to be saved -->

            <div class="form-group">
                <label for="cardNumber">Card Number:</label>
                <input type="text" id="cardNumber" name="cardNumber" required>
            </div>
            <div class="form-group">
                <label for="cardHolderName">Card Holder Name:</label>
                <input type="text" id="cardHolderName" name="cardHolderName" required>
            </div>
            <div class="form-group">
                <label for="cvv">CVV:</label>
                <input type="text" id="cvv" name="cvv" required>
            </div>
            <div class="form-group">
                <label for="expiryDate">Expiry Date (MM/YY):</label>
                <input type="text" id="expiryDate" name="expiryDate" required>
            </div>
            <div class="form-group">
                <button type="submit">Submit Payment Details</button>
            </div>
        </form>
    </div>
</body>
</html>
