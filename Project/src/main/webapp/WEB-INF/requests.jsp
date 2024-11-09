<!DOCTYPE html>
<html>
<head>
    <title>Admin - Requests</title>
</head>
<body>
    <h1>Requests</h1>
    <table>
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
                    <form action="/admin/allocate" method="post">
                        <input type="hidden" name="requestId" value="${request.id}">
                        <select name="riderId">
                            <!-- Populate with available riders -->
                        </select>
                        <input type="submit" value="Allocate Rider">
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
