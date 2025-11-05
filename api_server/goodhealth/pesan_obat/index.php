<?php
include '../db.php';

$result = null;

$id_pasien = $_GET['id_pasien'] ?? null;
$is_selesai = $_GET['is_selesai'] ?? null;

// FIX 1: Menambahkan *
$query = "SELECT * FROM pesan_obat";
$where_clauses = [];

// FIX 2: Memperbaiki logika WHERE
if ($id_pasien != null) {
    $where_clauses[] = "id_pasien = '$id_pasien'";
}

if ($is_selesai == '0' || $is_selesai == '1') {
    $where_clauses[] = "is_selesai = '$is_selesai'";
}

// FIX 3: Menggabungkan klausa WHERE dengan benar
if (count($where_clauses) > 0) {
    $query = $query . " WHERE " . implode(' AND ', $where_clauses);
}

$sql = $conn->query($query);
$result_pesan_obat = $sql->fetchAll(PDO::FETCH_ASSOC);

$result = $result_pesan_obat;

// FIX 4: Memperbaiki loop foreach untuk mengambil data pasien
foreach ($result as $i => $regis) {
    $id_pasien_loop = $regis['id_pasien'];
    $result_pasien = $conn->query("SELECT * FROM pasien WHERE id_pasien = '$id_pasien_loop'")->fetch(PDO::FETCH_ASSOC);
    $result[$i]['id_pasien'] = $result_pasien;
}

// Pastikan tidak ada output lain sebelum ini
echo json_encode($result);
?>