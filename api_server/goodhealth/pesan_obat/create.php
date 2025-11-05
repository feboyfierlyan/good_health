<?php
include '../db.php';

$response = array(); // Gunakan array agar aman
try {
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $data = json_decode(file_get_contents("php://input"));

        // Ambil data dari Flutter (sesuai modul)
        $id_pasien = $data->id_pasien;
        $waktu = date('Y-m-d H:i:s'); // Ambil waktu server saat ini
        $alamat = $data->alamat;
        $lat = $data->lat;
        $lng = $data->lng; // Pastikan ini 'lng', bukan 'Ing'
        $list_pesanan = $data->list_pesanan;
        $total_biaya = $data->total_biaya;
        $ket = $data->ket;

        // Query INSERT yang benar (tidak ada id_obat)
        $query = "INSERT INTO pesan_obat (id_pasien, waktu, alamat, lat, lng, list_pesanan, total_biaya, ket) 
                  VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        $stmt = $conn->prepare($query);

        // Eksekusi dengan array
        $stmt->execute([$id_pasien, $waktu, $alamat, $lat, $lng, $list_pesanan, $total_biaya, $ket]);

        $response['message'] = "Berhasil melakukan pemesanan obat, silahkan tunggu driver mengantarkan obat anda.";
        $response['id_pesan_obat'] = $conn->lastInsertId();
    }
} catch (Exception $e) {
    http_response_code(500); // Kirim kode error
    $response['message'] = "Gagal: " . $e->getMessage();
    $response['id_pesan_obat'] = null;
}

echo json_encode($response);
?>