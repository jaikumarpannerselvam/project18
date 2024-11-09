<!DOCTYPE html>
<html>
<head>
    <title>Login - Logistics Management System</title>
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
        input[type="text"], input[type="password"] {
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
            background: #3B8A7F;
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
        <h2>Login</h2>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <form action="/login" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <input type="submit" value="Login">
        </form>
        <div class="nav-buttons">
            <a href="/register" class="nav-button">Register</a>
        </div>
    </div>
</body>
</html>
