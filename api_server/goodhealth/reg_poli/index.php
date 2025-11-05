<?php
include '../db.php';

$result = null;

$id_pasien = $_GET['id_pasien'] ?? null;
$id_dokter = $_GET['id_dokter'] ?? null;
$poli = $_GET['poli'] ?? null;
$tgl_booking_start = $_GET['tgl_booking_start'] ?? null;
$tgl_booking_end = $_GET['tgl_booking_end'] ?? null;

// FIX 1: Menambahkan *
$query = "SELECT * FROM regis_poli";
$where_clauses = [];

// FIX 2: Memperbaiki logika WHERE
if ($id_pasien != null) {
    $where_clauses[] = "id_pasien = '$id_pasien'";
}

if ($id_dokter != null) {
    $where_clauses[] = "id_dokter = '$id_dokter'";
}

if ($poli != null) {
    $where_clauses[] = "poli = '$poli'";
}

if ($tgl_booking_start != null && $tgl_booking_end != null) {
    $where_clauses[] = "tgl_booking BETWEEN '$tgl_booking_start' AND '$tgl_booking_end'";
}

// FIX 3: Menggabungkan klausa WHERE dengan benar
if (count($where_clauses) > 0) {
    $query = $query . " WHERE " . implode(' AND ', $where_clauses);
}

$sql = $conn->query($query);
$result_regis_poli = $sql->fetchAll(PDO::FETCH_ASSOC);

$result = $result_regis_poli;

// FIX 4: Memperbaiki loop foreach untuk mengambil data terkait
foreach ($result as $i => $regis) {
    $id_pasien_loop = $regis['id_pasien'];
    $result_pasien = $conn->query("SELECT * FROM pasien WHERE id_pasien = '$id_pasien_loop'")->fetch(PDO::FETCH_ASSOC);
    $result[$i]['id_pasien'] = $result_pasien;

    $id_dokter_loop = $regis['id_dokter'];
    $result_dokter = $conn->query("SELECT * FROM dokter WHERE id_dokter = '$id_dokter_loop'")->fetch(PDO::FETCH_ASSOC);
    $result[$i]['id_dokter'] = $result_dokter;
}

// Pastikan tidak ada output lain sebelum ini
echo json_encode($result);
?>