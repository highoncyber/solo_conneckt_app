<?php
require '../config.php';
$output = array();
if ($conn) {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        //if (!empty($_FILES)) {
        if (isset($_POST['auth_key']) && $_POST['auth_key'] == $auth_key) {

            $ActiveProfile = $_POST['ActiveProfile'];
            $user_id  = $_POST['user_id'];

            $query = "UPDATE `Users` SET `ActiveProfile`=$ActiveProfile WHERE `user_id`=user_id";
            $run = mysqli_query($conn, $query);
            if (mysqli_num_rows($run) > 0) {
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
            // $temp = array();
            // $temp['code'] = "Access forbidden";
            echo "Access forbidden";
            // array_push($output, $temp);
            // echo json_encode($output, JSON_UNESCAPED_SLASHES);
        }
    } else {
        // $temp = array();
        $temp['code'] = "Connection Error";
        // array_push($output, $temp);
        // echo json_encode($output, JSON_UNESCAPED_SLASHES)
    }
}
