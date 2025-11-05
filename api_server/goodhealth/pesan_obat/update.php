<?php
include '../db.php'; // FIX: Menambahkan tanda kutip

$response = array(); // Gunakan array agar aman
try {
    $id = $_GET['id'];

    // FIX: Menambahkan spasi setelah SET
    $query = "UPDATE pesan_obat SET is_selesai = '1' WHERE id_pesan_obat = '$id'";

    $stmt = $conn->prepare($query);
    $stmt->execute(); // FIX: Menambahkan ()

    $response['message'] = "Pesanan berhasil diupdate";

} catch (Exception $e) {
    http_response_code(500);
    $response['message'] = "Gagal: " . $e->getMessage();
}

echo json_encode($response);
?>