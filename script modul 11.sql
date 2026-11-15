-- ============================================================
-- SISTEM INFORMASI SEHATKU - MODUL 11
-- FILE DATABASE + SCRIPT PRAKTIKUM
-- DBMS: MySQL (dump sumber: MySQL 8.0.30; script JSON: MySQL 8.4 LTS)
-- ============================================================

CREATE DATABASE IF NOT EXISTS sistem_sehatku
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE sistem_sehatku;

-- ============================================================
-- BAGIAN A: STRUKTUR TABEL DAN DATA AWAL DATABASE
-- Sumber: sistem_sehatku.sql
-- ============================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sistem_sehatku`
--

-- --------------------------------------------------------

--
-- Table structure for table `evaluasi_kesehatan`
--

CREATE TABLE `evaluasi_kesehatan` (
  `id_evaluasi` int NOT NULL,
  `id_petugas` int NOT NULL,
  `periode_evaluasi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kategori_keluhan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hasil_evaluasi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `rekomendasi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `tanggal_evaluasi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `konten_edukasi`
--

CREATE TABLE `konten_edukasi` (
  `id_edukasi` int NOT NULL,
  `id_petugas` int NOT NULL,
  `judul` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `isi_materi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_publikasi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `laporan_keluhan`
--

CREATE TABLE `laporan_keluhan` (
  `id_laporan` int NOT NULL,
  `id_pengguna` int NOT NULL,
  `jenis_keluhan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `detail_klinis` json DEFAULT NULL,
  `lokasi` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `waktu_kejadian` datetime DEFAULT NULL,
  `tanggal_laporan` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('menunggu','diproses','selesai','ditolak') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'menunggu'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `laporan_keluhan`
--

INSERT INTO `laporan_keluhan` (`id_laporan`, `id_pengguna`, `jenis_keluhan`, `deskripsi`, `detail_klinis`, `lokasi`, `waktu_kejadian`, `tanggal_laporan`, `status`) VALUES
(1, 1, 'Flu', 'Mengalami flu', '{\"suhu_tubuh\": \"39.2 C\", \"durasi_hari\": 3, \"kategori_medis\": \"Penyakit Umum\", \"gejala_penyerta\": [\"pusing\", \"menggigil\"]}', 'Asrama A', NULL, '2026-11-01 21:35:51', 'diproses'),
(2, 1, 'Batuk', 'Mengalami batuk', NULL, 'Asrama A', NULL, '2026-11-01 21:35:51', 'diproses'),
(3, 1, 'Pusing', 'Mengalami pusing', NULL, 'Kampus', NULL, '2026-11-01 21:35:51', 'selesai'),
(4, 2, 'Demam', 'Mengalami demam', NULL, 'Asrama B', NULL, '2026-11-01 21:35:51', 'menunggu'),
(5, 2, 'Sakit Perut', 'Mengalami sakit perut', NULL, 'Kampus', NULL, '2026-11-01 21:35:51', 'diproses'),
(6, 3, 'Alergi', 'Mengalami alergi', NULL, 'Asrama C', NULL, '2026-11-01 21:35:51', 'menunggu'),
(7, 1, 'Alergi', 'Contoh pengujian transaksi', NULL, 'Kampus', NULL, '2026-11-08 21:05:35', 'menunggu'),
(8, 5, 'Sakit kaki', 'Contoh pengujian transaksi', '{\"penyebab\": \"Terkilir futsal\", \"bagian_tubuh\": \"Pergelangan Kaki Kanan\", \"tingkat_nyeri\": \"8/10\", \"kategori_medis\": \"Cedera Fisik\", \"tindakan_pertolongan_pertama\": \"Kompres es dan balut perban elastis\"}', 'Kampus 2', NULL, '2026-11-08 21:38:08', 'menunggu'),
(9, 3, 'Demam', 'Mengalami demam selama dua hari', '{\"durasi\": \"2 hari\", \"pemeriksaan\": {\"denyut_nadi\": 88, \"tekanan_darah\": \"120/80\"}, \"suhu_celsius\": 38.5, \"gejala_tambahan\": [\"sakit kepala\", \"menggigil\"]}', 'Asrama A', '2026-11-14 13:48:01', '2026-11-14 13:48:01', 'menunggu');

-- --------------------------------------------------------

--
-- Table structure for table `notifikasi`
--

CREATE TABLE `notifikasi` (
  `id_notifikasi` int NOT NULL,
  `id_pengguna` int NOT NULL,
  `id_laporan` int DEFAULT NULL,
  `judul_notifikasi` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `isi_notifikasi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `tanggal_dibuat` datetime DEFAULT CURRENT_TIMESTAMP,
  `status_baca` enum('belum_dibaca','sudah_dibaca') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'belum_dibaca'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE `pengguna` (
  `id_pengguna` int NOT NULL,
  `nama` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nim_nip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `peran` enum('mahasiswa','petugas','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_daftar` datetime DEFAULT CURRENT_TIMESTAMP,
  `total_laporan` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pengguna`
--

INSERT INTO `pengguna` (`id_pengguna`, `nama`, `email`, `nim_nip`, `password`, `peran`, `tanggal_daftar`, `total_laporan`) VALUES
(1, 'Andi', 'andi@gmail.com', '2301001', '12345', 'mahasiswa', '2026-11-01 21:35:51', 3),
(2, 'Budi', 'budi@gmail.com', '2301002', '12345', 'mahasiswa', '2026-11-01 21:35:51', 2),
(3, 'Citra', 'citra@gmail.com', '2301003', '12345', 'mahasiswa', '2026-11-01 21:35:51', 1),
(4, 'Admin', 'admin@gmail.com', 'ADM001', '12345', 'admin', '2026-11-01 21:35:51', 0),
(5, 'Doni', 'doni@gmail.com', '2301004', '12345', 'mahasiswa', '2026-11-08 21:16:27', 0);

-- --------------------------------------------------------

--
-- Table structure for table `riwayat_status_laporan`
--

CREATE TABLE `riwayat_status_laporan` (
  `id_riwayat` int NOT NULL,
  `id_laporan` int NOT NULL,
  `id_pengguna` int NOT NULL,
  `status_sebelumnya` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_baru` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_perubahan` datetime DEFAULT CURRENT_TIMESTAMP,
  `catatan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `riwayat_status_laporan`
--

INSERT INTO `riwayat_status_laporan` (`id_riwayat`, `id_laporan`, `id_pengguna`, `status_sebelumnya`, `status_baru`, `tanggal_perubahan`, `catatan`) VALUES
(212, 1, 1, 'menunggu', 'diproses', '2026-11-02 15:50:57', 'semoga lekas sembuh'),
(234, 2, 1, 'diproses', 'selesai', '2026-11-02 15:55:59', 'semoga lekas sembuh'),
(255, 3, 2, 'menunggu', 'diproses', '2026-11-03 15:50:57', 'semoga lekas sembuh'),
(256, 4, 2, 'diproses', 'selesai', '2026-11-03 15:55:59', 'semoga lekas sembuh'),
(257, 5, 3, 'menunggu', 'selesai', '2026-12-04 15:50:57', 'semoga lekas sembuh'),
(258, 6, 3, 'menunggu', 'selesai', '2026-12-04 15:55:59', 'semoga lekas sembuh');

-- --------------------------------------------------------

--
-- Table structure for table `tindak_lanjut`
--

CREATE TABLE `tindak_lanjut` (
  `id_tindak_lanjut` int NOT NULL,
  `id_laporan` int NOT NULL,
  `id_petugas` int NOT NULL,
  `tanggal_penanganan` datetime DEFAULT NULL,
  `catatan_perbaikan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status_akhir` enum('selesai','belum_selesai') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `verifikasi_laporan`
--

CREATE TABLE `verifikasi_laporan` (
  `id_verifikasi` int NOT NULL,
  `id_laporan` int NOT NULL,
  `id_admin` int NOT NULL,
  `tanggal_verifikasi` datetime DEFAULT CURRENT_TIMESTAMP,
  `hasil_verifikasi` enum('disetujui','ditolak') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `catatan_verifikasi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `verifikasi_laporan`
--

INSERT INTO `verifikasi_laporan` (`id_verifikasi`, `id_laporan`, `id_admin`, `tanggal_verifikasi`, `hasil_verifikasi`, `catatan_verifikasi`) VALUES
(123456, 1, 4, '2026-11-02 15:50:43', 'disetujui', 'Laporan sesuai dan lengkap'),
(345678, 2, 4, '2026-11-02 15:55:57', 'disetujui', 'Laporan sesuai dan lengkap'),
(543326, 3, 4, '2026-12-04 15:50:57', 'disetujui', 'Laporan sesuai dan lengkap'),
(543327, 4, 4, '2026-11-03 15:54:00', 'disetujui', 'Laporan sesuai dan lengkap'),
(543328, 5, 4, '2026-11-04 15:52:00', 'disetujui', 'Laporan sesuai dan lengkap'),
(543329, 6, 4, '2026-11-04 15:54:00', 'disetujui', 'Laporan sesuai dan lengkap');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `evaluasi_kesehatan`
--
ALTER TABLE `evaluasi_kesehatan`
  ADD PRIMARY KEY (`id_evaluasi`),
  ADD KEY `fk_evaluasi_petugas` (`id_petugas`);

--
-- Indexes for table `konten_edukasi`
--
ALTER TABLE `konten_edukasi`
  ADD PRIMARY KEY (`id_edukasi`),
  ADD KEY `fk_edukasi_petugas` (`id_petugas`);

--
-- Indexes for table `laporan_keluhan`
--
ALTER TABLE `laporan_keluhan`
  ADD PRIMARY KEY (`id_laporan`),
  ADD KEY `fk_laporan_pengguna` (`id_pengguna`),
  ADD KEY `idx_status_laporan` (`status`);

--
-- Indexes for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD PRIMARY KEY (`id_notifikasi`),
  ADD KEY `fk_notifikasi_pengguna` (`id_pengguna`),
  ADD KEY `fk_notifikasi_laporan` (`id_laporan`);

--
-- Indexes for table `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id_pengguna`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nim_nip` (`nim_nip`);

--
-- Indexes for table `riwayat_status_laporan`
--
ALTER TABLE `riwayat_status_laporan`
  ADD PRIMARY KEY (`id_riwayat`),
  ADD KEY `fk_riwayat_laporan` (`id_laporan`),
  ADD KEY `fk_riwayat_pengguna` (`id_pengguna`);

--
-- Indexes for table `tindak_lanjut`
--
ALTER TABLE `tindak_lanjut`
  ADD PRIMARY KEY (`id_tindak_lanjut`),
  ADD KEY `fk_tindak_lanjut_laporan` (`id_laporan`),
  ADD KEY `fk_tindak_lanjut_petugas` (`id_petugas`);

--
-- Indexes for table `verifikasi_laporan`
--
ALTER TABLE `verifikasi_laporan`
  ADD PRIMARY KEY (`id_verifikasi`),
  ADD KEY `fk_verifikasi_laporan` (`id_laporan`),
  ADD KEY `fk_verifikasi_admin` (`id_admin`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `evaluasi_kesehatan`
--
ALTER TABLE `evaluasi_kesehatan`
  MODIFY `id_evaluasi` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `konten_edukasi`
--
ALTER TABLE `konten_edukasi`
  MODIFY `id_edukasi` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `laporan_keluhan`
--
ALTER TABLE `laporan_keluhan`
  MODIFY `id_laporan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `notifikasi`
--
ALTER TABLE `notifikasi`
  MODIFY `id_notifikasi` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id_pengguna` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `riwayat_status_laporan`
--
ALTER TABLE `riwayat_status_laporan`
  MODIFY `id_riwayat` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=259;

--
-- AUTO_INCREMENT for table `tindak_lanjut`
--
ALTER TABLE `tindak_lanjut`
  MODIFY `id_tindak_lanjut` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `verifikasi_laporan`
--
ALTER TABLE `verifikasi_laporan`
  MODIFY `id_verifikasi` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=543330;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `evaluasi_kesehatan`
--
ALTER TABLE `evaluasi_kesehatan`
  ADD CONSTRAINT `fk_evaluasi_petugas` FOREIGN KEY (`id_petugas`) REFERENCES `pengguna` (`id_pengguna`);

--
-- Constraints for table `konten_edukasi`
--
ALTER TABLE `konten_edukasi`
  ADD CONSTRAINT `fk_edukasi_petugas` FOREIGN KEY (`id_petugas`) REFERENCES `pengguna` (`id_pengguna`);

--
-- Constraints for table `laporan_keluhan`
--
ALTER TABLE `laporan_keluhan`
  ADD CONSTRAINT `fk_laporan_pengguna` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna` (`id_pengguna`);

--
-- Constraints for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD CONSTRAINT `fk_notifikasi_laporan` FOREIGN KEY (`id_laporan`) REFERENCES `laporan_keluhan` (`id_laporan`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_notifikasi_pengguna` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna` (`id_pengguna`);

--
-- Constraints for table `riwayat_status_laporan`
--
ALTER TABLE `riwayat_status_laporan`
  ADD CONSTRAINT `fk_riwayat_laporan` FOREIGN KEY (`id_laporan`) REFERENCES `laporan_keluhan` (`id_laporan`),
  ADD CONSTRAINT `fk_riwayat_pengguna` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna` (`id_pengguna`);

--
-- Constraints for table `tindak_lanjut`
--
ALTER TABLE `tindak_lanjut`
  ADD CONSTRAINT `fk_tindak_lanjut_laporan` FOREIGN KEY (`id_laporan`) REFERENCES `laporan_keluhan` (`id_laporan`),
  ADD CONSTRAINT `fk_tindak_lanjut_petugas` FOREIGN KEY (`id_petugas`) REFERENCES `pengguna` (`id_pengguna`);

--
-- Constraints for table `verifikasi_laporan`
--
ALTER TABLE `verifikasi_laporan`
  ADD CONSTRAINT `fk_verifikasi_admin` FOREIGN KEY (`id_admin`) REFERENCES `pengguna` (`id_pengguna`),
  ADD CONSTRAINT `fk_verifikasi_laporan` FOREIGN KEY (`id_laporan`) REFERENCES `laporan_keluhan` (`id_laporan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;



-- ============================================================
-- BAGIAN B: SCRIPT PRAKTIKUM DAN PENGUJIAN JSON MODUL 11
-- ============================================================

-- ============================================================
-- SISTEM INFORMASI SEHATKU
-- Kumpulan Script SQL Praktikum Basisdata Modul 11
-- DBMS : MySQL 8.4 LTS
-- Database: sistem_sehatku
--
-- Isi:
-- 1. Identifikasi DBMS
-- 2. Persiapan kolom JSON
-- 3. INSERT, SELECT, UPDATE, pencarian, dan penghapusan atribut JSON
-- 4. Query pemodelan objek (kategori Penyakit Umum dan Cedera Fisik)
--
-- PENTING:
-- - Impor/siapkan database proyek sistem_sehatku terlebih dahulu.
-- - Script ini mengasumsikan tabel laporan_keluhan sudah tersedia.
-- - Tabel laporan_keluhan harus memiliki kolom:
--   id_laporan, id_pengguna, jenis_keluhan, deskripsi, lokasi,
--   waktu_kejadian, tanggal_laporan (jika ada), dan status.
-- - Pastikan id_pengguna = 3 tersedia sebelum menjalankan INSERT.
-- - Beberapa UPDATE contoh menargetkan id_laporan 1 dan 8.
--   Sesuaikan ID jika data tersebut tidak ada di database Anda.
-- - Jalankan bagian "Persiapan kolom JSON" satu kali saja.
-- ============================================================

USE sistem_sehatku;

-- ============================================================
-- 1. IDENTIFIKASI DBMS
-- ============================================================

SELECT
    VERSION() AS versi_dbms,
    @@version_comment AS distribusi_dbms,
    DATABASE() AS db_aktif;

SHOW ENGINES;


-- ============================================================
-- 2. PERSIAPAN KOLOM JSON
-- Diambil dari bagian praktikum dan post-test.
-- Jalankan ALTER TABLE ini hanya jika kolom detail_klinis
-- belum tersedia. Jika sudah ada, lewati perintah ALTER TABLE.
-- ============================================================

-- Kolom detail_klinis sudah tersedia pada struktur tabel dari file dump.
DESCRIBE laporan_keluhan;


-- ============================================================
-- 3. CONTOH DATA JSON UNTUK LAPORAN YANG SUDAH ADA
-- Mengisi detail klinis untuk id_laporan 1 dan 8.
-- ============================================================

UPDATE laporan_keluhan
SET detail_klinis = JSON_OBJECT(
    'suhu_tubuh', '38.5 C',
    'durasi_hari', 3,
    'gejala_penyerta', JSON_ARRAY('pusing', 'menggigil'),
    'kategori_medis', 'Penyakit Umum'
)
WHERE id_laporan = 1;

UPDATE laporan_keluhan
SET detail_klinis = JSON_OBJECT(
    'bagian_tubuh', 'Pergelangan Kaki Kanan',
    'tingkat_nyeri', '8/10',
    'penyebab', 'Terkilir futsal',
    'kategori_medis', 'Cedera Fisik',
    'rujukan_faskes', 'Klinik Kampus'
)
WHERE id_laporan = 8;

SELECT
    id_laporan,
    jenis_keluhan,
    lokasi,
    status,
    detail_klinis
FROM laporan_keluhan
ORDER BY id_laporan;


-- ============================================================
-- 4. SELECT / MEMBACA ATRIBUT JSON
-- Mengambil nilai suhu_tubuh dari dokumen JSON.
-- ============================================================

SELECT
    id_laporan,
    jenis_keluhan,
    JSON_EXTRACT(detail_klinis, '$.suhu_tubuh') AS suhu_tubuh
FROM laporan_keluhan
WHERE JSON_EXTRACT(detail_klinis, '$.suhu_tubuh') IS NOT NULL;


-- ============================================================
-- 5. UPDATE / MENGUBAH NILAI ATRIBUT JSON
-- Mengubah suhu_tubuh pada laporan dengan id_laporan = 1.
-- ============================================================

UPDATE laporan_keluhan
SET detail_klinis = JSON_SET(
    detail_klinis,
    '$.suhu_tubuh',
    '39.2 C'
)
WHERE id_laporan = 1;

SELECT
    id_laporan,
    jenis_keluhan,
    JSON_EXTRACT(detail_klinis, '$.suhu_tubuh') AS suhu_terbaru
FROM laporan_keluhan
WHERE id_laporan = 1;


-- ============================================================
-- 6. MENAMBAHKAN ATRIBUT BARU KE DOKUMEN JSON
-- ============================================================

UPDATE laporan_keluhan
SET detail_klinis = JSON_SET(
    detail_klinis,
    '$.tindakan_pertolongan_pertama',
    'Kompres es dan balut perban elastis'
)
WHERE id_laporan = 8;

SELECT
    id_laporan,
    jenis_keluhan,
    detail_klinis
FROM laporan_keluhan
WHERE id_laporan = 8;


-- ============================================================
-- 7. DELETE / MENGHAPUS ATRIBUT JSON
-- Catatan: JSON_REMOVE menghapus key dari dokumen JSON,
-- bukan menghapus seluruh baris laporan.
-- ============================================================

UPDATE laporan_keluhan
SET detail_klinis = JSON_REMOVE(
    detail_klinis,
    '$.rujukan_faskes'
)
WHERE id_laporan = 8;

SELECT
    id_laporan,
    jenis_keluhan,
    detail_klinis
FROM laporan_keluhan
WHERE id_laporan = 8;


-- ============================================================
-- 8. PENCARIAN / FILTER BERDASARKAN ATRIBUT JSON
-- ============================================================

SELECT
    id_laporan,
    jenis_keluhan,
    deskripsi,
    detail_klinis
FROM laporan_keluhan
WHERE JSON_UNQUOTE(
    JSON_EXTRACT(detail_klinis, '$.tingkat_nyeri')
) = '8/10';


-- ============================================================
-- 9. QUERY PEMODELAN OBJEK / KATEGORI PENYAKIT UMUM
-- Merepresentasikan data subclass Penyakit Umum.
-- ============================================================

SELECT
    id_laporan,
    jenis_keluhan,
    lokasi,
    status,
    JSON_EXTRACT(detail_klinis, '$.suhu_tubuh') AS suhu,
    JSON_EXTRACT(detail_klinis, '$.durasi_hari') AS durasi_hari
FROM laporan_keluhan
WHERE JSON_UNQUOTE(
    JSON_EXTRACT(detail_klinis, '$.kategori_medis')
) = 'Penyakit Umum';


-- ============================================================
-- 10. QUERY PEMODELAN OBJEK / KATEGORI CEDERA FISIK
-- Merepresentasikan data subclass Cedera Fisik.
-- ============================================================

SELECT
    id_laporan,
    jenis_keluhan,
    lokasi,
    status,
    JSON_UNQUOTE(
        JSON_EXTRACT(detail_klinis, '$.bagian_tubuh')
    ) AS bagian_tubuh,
    JSON_UNQUOTE(
        JSON_EXTRACT(detail_klinis, '$.tingkat_nyeri')
    ) AS tingkat_nyeri
FROM laporan_keluhan
WHERE JSON_UNQUOTE(
    JSON_EXTRACT(detail_klinis, '$.kategori_medis')
) = 'Cedera Fisik';


-- ============================================================
-- 11. POST-TEST: INSERT DATA LAPORAN DENGAN JSON_OBJECT()
-- JSON disusun dengan key suhu_tubuh agar sesuai dengan query
-- SELECT dan UPDATE suhu_tubuh pada bagian pengujian.
-- ============================================================

INSERT INTO laporan_keluhan
(
    id_pengguna,
    jenis_keluhan,
    deskripsi,
    detail_klinis,
    lokasi,
    waktu_kejadian,
    status
)
VALUES
(
    3,
    'Demam',
    'Mengalami demam selama dua hari',
    JSON_OBJECT(
        'suhu_tubuh', 38.5,
        'durasi', '2 hari',
        'gejala_tambahan', JSON_ARRAY('sakit kepala', 'menggigil'),
        'pemeriksaan', JSON_OBJECT(
            'tekanan_darah', '120/80',
            'denyut_nadi', 88
        ),
        'kategori_medis', 'Penyakit Umum'
    ),
    'Asrama A',
    NOW(),
    'menunggu'
);

SET @id_json = LAST_INSERT_ID();

SELECT
    @id_json AS id_laporan_baru;


-- ============================================================
-- 12. POST-TEST: SELECT DATA JSON HASIL INSERT
-- ============================================================

SELECT
    id_laporan,
    jenis_keluhan,
    JSON_EXTRACT(detail_klinis, '$.suhu_tubuh') AS suhu_tubuh,
    detail_klinis
FROM laporan_keluhan
WHERE id_laporan = @id_json;


-- ============================================================
-- 13. POST-TEST: UPDATE ATRIBUT JSON HASIL INSERT
-- ============================================================

UPDATE laporan_keluhan
SET detail_klinis = JSON_SET(
    detail_klinis,
    '$.suhu_tubuh',
    39.2
)
WHERE id_laporan = @id_json;

SELECT
    id_laporan,
    jenis_keluhan,
    JSON_EXTRACT(detail_klinis, '$.suhu_tubuh') AS suhu_terbaru
FROM laporan_keluhan
WHERE id_laporan = @id_json;


-- ============================================================
-- 14. POST-TEST: DELETE ATRIBUT JSON HASIL INSERT
-- Contoh menambahkan atribut rujukan_faskes terlebih dahulu,
-- kemudian menghapusnya dengan JSON_REMOVE.
-- ============================================================

UPDATE laporan_keluhan
SET detail_klinis = JSON_SET(
    detail_klinis,
    '$.rujukan_faskes',
    'Klinik Kampus'
)
WHERE id_laporan = @id_json;

UPDATE laporan_keluhan
SET detail_klinis = JSON_REMOVE(
    detail_klinis,
    '$.rujukan_faskes'
)
WHERE id_laporan = @id_json;

SELECT
    id_laporan,
    jenis_keluhan,
    detail_klinis
FROM laporan_keluhan
WHERE id_laporan = @id_json;
