<?php
include 'db.php';

$data = json_decode(file_get_contents("php://input"));
$username = $data->username;
$password = sha1($data->password); // Database PDF 2 Anda menggunakan sha1

$query_user = "SELECT * FROM user WHERE username = '$username' AND password = '$password'";
$sql = $conn->query($query_user);
$result = $sql->fetch(PDO::FETCH_ASSOC);
$response = null;

if ($result != false) {
    $id_pasien = $result['id_pasien'];
    $query_pasien = "SELECT * FROM pasien WHERE id_pasien = '$id_pasien'";
    $result_pasien = $conn->query($query_pasien)->fetch(PDO::FETCH_ASSOC);
    
    // Ini adalah struktur dari PDF 2 Anda
    $response['message'] = "Selamat datang " . $result['username'];
    $response['user'] = $result;
    
    // --- PERBAIKAN DI SINI ---
    // Mengganti 'id_pasien' dengan objek pasien JIKA ADA (bukan 'false')
    // Jika tidak ada, kirim 'null'
    $response['user']['id_pasien'] = ($result_pasien != false) ? $result_pasien : null;

} else {
    http_response_code(401);
    $response['message'] = "Username atau Password salah";
    $response['user'] = null;
}

echo json_encode($response);
?>