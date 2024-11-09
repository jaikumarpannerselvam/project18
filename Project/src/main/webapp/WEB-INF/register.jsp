<!DOCTYPE html>
<html>
<head>
    <title>Register - Logistics Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #e9ecef;
        }
        .container {
            width: 50%;
            margin: auto;
            padding: 2em;
            background: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 2em;
        }
        h2 {
            margin-top: 0;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 0.5em;
            font-weight: bold;
        }
        input[type="text"], input[type="password"], input[type="email"], select {
            margin-bottom: 1em;
            padding: 0.5em;
            font-size: 1em;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"], .nav-button {
            padding: 0.75em;
            font-size: 1em;
            color: #fff;
            background: #2C6E8F;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 1em;
        }
        input[type="submit"]:hover, .nav-button:hover {
            background: #0056b3;
        }
        .error {
            color: red;
            margin-bottom: 1em;
        }
        .nav-buttons {
            margin-top: 1em;
        }
        .nav-buttons a {
            color: #fff;
            text-decoration: none;
            background: #28a745;
            padding: 0.75em;
            border-radius: 4px;
        }
        .nav-buttons a:hover {
            background: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Register</h2>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <form action="/register" method="post">
            <label for="newUsername">Username:</label>
            <input type="text" id="newUsername" name="username" required>
            <label for="newPassword">Password:</label>
            <input type="password" id="newPassword" name="password" required>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <label for="role">Role:</label>
            <select id="role" name="role">
                <option value="Sender">Sender</option>
                <option value="Rider">Rider</option>
                <option value="Admin">Admin</option>
            </select>
            <input type="submit" value="Register">
        </form>
        <div class="nav-buttons">
            <a href="/login" class="nav-button">Login</a>
        </div>
    </div>
</body>
</html>
