<?php
// Diambil dari Modul Backend PDF 2
// File ini HANYA menerima 'nama', 'hp', 'email'
include '../db.php';

$response = null;
try {
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $data = json_decode(file_get_contents("php://input"));
        
        // Sesuaikan dengan nama kolom di database 
        // Modul PDF 2 menggunakan 'nama', 'hp', 'email'
        $nama = $data->nama ?? "";
        $hp = $data->hp ?? "";
        $email = $data->email ?? "";
        
        // Transaksi
        $conn->beginTransaction();
        
        // 1. Insert ke tabel 'pasien'
        $query_pasien = "INSERT INTO pasien (nama, hp, email) VALUES (?, ?, ?)";
        $stmt_pasien = $conn->prepare($query_pasien);
        $stmt_pasien->execute([$nama, $hp, $email]);
        $id_pasien = $conn->lastInsertId();
        
        // 2. Insert ke tabel 'user' (Username dan Password adalah NOMOR HP)
        $query_user = "INSERT INTO user (username, password, id_pasien) VALUES (?, ?, ?)";
        $stmt_user = $conn->prepare($query_user);
        $stmt_user->execute([$hp, sha1($hp), $id_pasien]); // Password di-hash
        
        $conn->commit();
        
        // Kirim pesan sukses dari PDF 2
        $response['message'] = "Successful! please login using your phone number as username and password";
    }
} catch (Exception $e) {
    if ($conn->inTransaction()) {
        $conn->rollback();
    }
    http_response_code(500);
    $response['message'] = "Gagal: " . $e->getMessage();
}

echo json_encode($response);
?>
