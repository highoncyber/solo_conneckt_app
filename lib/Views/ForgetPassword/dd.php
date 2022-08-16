<?php
require '../config.php';
$output = array();
if ($conn) {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        //if (!empty($_FILES)) {
        if (isset($_POST['auth_key']) && $_POST['auth_key'] == $auth_key) {

            $user_email = $_POST['user_email'];
            $user_password = $_POST['user_password'];

            $query2 = "SELECT `user_password` from `Users` WHERE `user_email`='$user_email'";
            if (mysqli_query($conn, $query2)) {
                $temp = array();
                $temp['code'] = 1;
                if ($temp['user_password'] != $user_password) {
                    $query = "UPDATE `Users` SET `user_password`='$user_password' WHERE `user_email`='$user_email'";

                    if (mysqli_query($conn, $query)) {
                        $temp = array();
                        $temp['code'] = 1;
                        array_push($output, $temp);
                        echo json_encode($output, JSON_UNESCAPED_SLASHES);
                    } else {
                        $temp = array();
                        $temp['code'] = 0;
                        array_push($output, $temp);
                        echo json_encode($output, JSON_UNESCAPED_SLASHES);
                    }
                } else {
                    $temp = array();
                    $temp['code'] = 3;
                    array_push($output, $temp);
                    echo json_encode($output, JSON_UNESCAPED_SLASHES);
                }
            } else {
                $temp = array();
                $temp['code'] = 0;
                array_push($output, $temp);
                echo json_encode($output, JSON_UNESCAPED_SLASHES);
            }
        } else {
            // $temp = array();
            // $temp['code'] = "Access forbidden";
            echo "Access forbidden";
            // array_push($output, $temp);
            // echo json_encode($output, JSON_UNESCAPED_SLASHES);
        }
    }
} else {
    // $temp = array();
    $temp['code'] = "Connection Error";
    // array_push($output, $temp);
    // echo json_encode($output, JSON_UNESCAPED_SLASHES)
}
