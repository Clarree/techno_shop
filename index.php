<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "techno_shop";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Помилка підключення: " . $conn->connect_error);
}

function очиститиВведення($input) {
    $input = trim($input);
    $input = stripslashes($input);
    $input = htmlspecialchars($input);
    return $input;
}

function відобразитиДані($conn) {
    $sql = "SELECT * FROM товар";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            echo "ID: " . $row["ID"] . " - Назва: " . $row["Назва"] . " - Ціна: " . $row["Ціна"] . "<br>";
        }
    } else {
        echo "0 результатів";
    }
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST["add_data"])) {
        $name = очиститиВведення($_POST["product_name"]);
        $price = очиститиВведення($_POST["product_price"]);

        $sql = $conn->prepare("INSERT INTO товар (Назва, Ціна) VALUES (?, ?)");
        $sql->bind_param("ss", $name, $price);

        if ($sql->execute()) {
            echo "Запис додано успішно";
        } else {
            echo "Помилка при додаванні запису: " . $conn->error;
        }
    }

    if (isset($_POST["delete_data"])) {
        // Валідуємо та очищуємо введені дані
        $id = isset($_POST["product_id"]) ? intval($_POST["product_id"]) : null;

        if ($id !== null) {
            $sql = "DELETE FROM товар WHERE ID=?";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("i", $id);

            if ($stmt->execute()) {
                echo "Запис видалено успішно";
            } else {
                echo "Помилка при видаленні запису: " . $conn->error;
            }
        } else {
            echo "Невірний ID для видалення";
        }
    }

    if (isset($_POST["update_data"])) {
        $id = очиститиВведення($_POST["product_id"]);
        $new_price = очиститиВведення($_POST["new_price"]);

        $sql = "UPDATE товар SET Ціна=? WHERE ID=?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("si", $new_price, $id);

        if ($stmt->execute()) {
            echo "Запис оновлено успішно";
        } else {
            echo "Помилка при оновленні запису: " . $conn->error;
        }
    }

    if (isset($_POST["register"])) {
        $login = очиститиВведення($_POST["login"]);
        $password = password_hash($_POST["password"], PASSWORD_BCRYPT);

        $sql = $conn->prepare("INSERT INTO користувач (Логін, Пароль) VALUES (?, ?)");
        $sql->bind_param("ss", $login, $password);

        if ($sql->execute()) {
            echo "Користувача зареєстровано успішно";
        } else {
            echo "Помилка при реєстрації користувача: " . $conn->error;
        }
    }

    if (isset($_POST["login_user"])) {
        $login = очиститиВведення($_POST["login"]);
        $password = $_POST["password"];

        $sql = "SELECT * FROM користувач WHERE Логін=?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("s", $login);
        $stmt->execute();

        $result = $stmt->get_result();

        if ($result->num_rows == 1) {
            $row = $result->fetch_assoc();
            if (password_verify($password, $row["Пароль"])) {
                echo "Успішний вхід";
            } else {
                echo "Неправильний пароль";
            }
        } else {
            echo "Користувача не знайдено";
        }
    }
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .main-container {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            max-width: 800px;
            width: 100%;
        }

        form {
            width: 60%;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h3 {
            color: #333;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border: 2px solid #4caf50;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th,
        td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #4caf50;
            color: white;
        }

        .success {
            color: #4caf50;
        }

        .error {
            color: #f44336;
        }

        .auth-container,
        .register-container {
            width: 30%;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>

<body>

    <div class="main-container">
        <form method="post" action="<?php echo $_SERVER['PHP_SELF'];?>">
            <?php відобразитиДані($conn); ?>

            <h3>Додати товар</h3>
            Назва: <input type="text" name="product_name"><br>
            Ціна: <input type="text" name="product_price"><br>
            <input type="submit" name="add_data" value="Додати">

            
            <h3>Видалити товар</h3>
            ID: <input type="text" name="product_id"><br>
            <input type="submit" name="delete_data" value="Видалити">

            
            <h3>Змінити ціну товару</h3>
            ID: <input type="text" name="product_id"><br>
            Нова ціна: <input type="text" name="new_price"><br>
            <input type="submit" name="update_data" value="Змінити">
        </form>

        <div class="auth-container">
            <h3>Авторизація</h3>
            Логін: <input type="text" name="login"><br>
            Пароль: <input type="password" name="password"><br>
            <input type="submit" name="login_user" value="Авторизуватись">
        </div>

        <div class="register-container">
            <h3>Реєстрація</h3>
            Логін: <input type="text" name="login"><br>
            Пароль: <input type="password" name="password"><br>
            <input type="submit" name="register" value="Зареєструвати">
        </div>
    </div>

</body>

</html>

<?php
$conn->close();
?>
