<?php
// Diambil dari Modul Backend PDF 2 Anda
include '../db.php';

$nama = $_GET['nama'] ?? null;
$query = "SELECT * FROM obat"; // Pastikan tabel Anda namanya 'obat'

if ($nama != null) {
    $query = $query . " WHERE nama LIKE '%$nama%'";
}

$sql = $conn->query($query);
echo json_encode($sql->fetchAll(PDO::FETCH_ASSOC));
?>
