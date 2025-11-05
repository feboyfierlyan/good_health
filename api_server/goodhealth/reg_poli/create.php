<?php
include '../db.php';

$response = array(); // Gunakan array agar aman
try {
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $data = json_decode(file_get_contents("php://input"));

        $id_pasien = $data->id_pasien;
        $id_dokter = $data->id_dokter;
        $tgl_booking = $data->tgl_booking;
        $poli = $data->poli;

        // FIX 1: 'tgl booking' diubah menjadi 'tgl_booking'
        // FIX 2: 'VALUES (?, 7, 7, 7' diubah menjadi VALUES (?, ?, ?, ?)'
        $query = "INSERT INTO regis_poli (id_pasien, id_dokter, tgl_booking, poli) VALUES (?, ?, ?, ?)";

        $stmt = $conn->prepare($query);

        // FIX 3: Sintaks 'execute' diubah agar menggunakan array
        $stmt->execute([$id_pasien, $id_dokter, $tgl_booking, $poli]);

        $response['message'] = "Booking registrasi berhasil dibuat";
        $response['id_regis_poli'] = $conn->lastInsertId();
    }
} catch (Exception $e) {
    http_response_code(500); // Kirim kode error jika gagal
    $response['message'] = "Gagal: " . $e->getMessage();
    $response['id_regis_poli'] = null;
}

echo json_encode($response);
?>