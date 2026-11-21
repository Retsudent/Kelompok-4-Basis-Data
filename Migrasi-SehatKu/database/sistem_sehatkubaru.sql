-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 19, 2026 at 12:15 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.33

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
  `periode_evaluasi` varchar(50) DEFAULT NULL,
  `kategori_keluhan` varchar(100) DEFAULT NULL,
  `hasil_evaluasi` text,
  `rekomendasi` text,
  `tanggal_evaluasi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `konten_edukasi`
--

CREATE TABLE `konten_edukasi` (
  `id_edukasi` int NOT NULL,
  `id_petugas` int NOT NULL,
  `judul` varchar(200) NOT NULL,
  `isi_materi` text NOT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `tanggal_publikasi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `laporan_keluhan`
--

CREATE TABLE `laporan_keluhan` (
  `id_laporan` int NOT NULL,
  `id_pengguna` int NOT NULL,
  `jenis_keluhan` varchar(100) NOT NULL,
  `deskripsi` text,
  `detail_fasilitas` json DEFAULT NULL,
  `lokasi` varchar(150) DEFAULT NULL,
  `waktu_kejadian` datetime DEFAULT NULL,
  `tanggal_laporan` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('menunggu','diproses','selesai','ditolak') DEFAULT 'menunggu'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `laporan_keluhan`
--

INSERT INTO `laporan_keluhan` (`id_laporan`, `id_pengguna`, `jenis_keluhan`, `deskripsi`, `detail_fasilitas`, `lokasi`, `waktu_kejadian`, `tanggal_laporan`, `status`) VALUES
(1, 1, 'Sanitasi Toilet', 'Toilet pria lantai 2 gedung kuliah kotor, bau menyengat, dan kran air mati', '{\"pasokan_air\": \"Mati / Kosong\", \"fasilitas_rusak\": [\"Kran patah\", \"Kloset mampet\", \"Kunci pintu rusak\"], \"tingkat_urgensi\": \"Sangat Darurat / Kritis\", \"kategori_fasilitas\": \"Sanitasi & Toilet\", \"kondisi_kebersihan\": \"Sangat Kotor\", \"tindakan_dibutuhkan\": \"Pembersihan segera dan perbaikan instalasi pipa air\"}', 'Gedung Kuliah Terpadu Lantai 2', NULL, '2026-11-01 20:40:27', 'diproses'),
(2, 1, 'Higienitas Kantin', 'Stan kantin 03 penyajian makanan tidak ditutup, banyak lalat, dan wastafel cuci berminyak', '{\"nama_stan\": \"Stan Makanan 03\", \"tingkat_urgensi\": \"Tinggi\", \"masalah_sanitasi\": [\"Makanan tidak ditutup\", \"Banyak lalat\", \"Tempat cuci piring berminyak\"], \"kategori_fasilitas\": \"Kantin & Makanan\", \"kondisi_kebersihan\": \"Kurang Higienis\", \"tindakan_dibutuhkan\": \"Teguran sanitasi pengelola kantin dan penyemprotan lalat\"}', 'Kantin Utama Kampus (Stan 03)', NULL, '2026-11-01 20:40:27', 'diproses'),
(3, 1, 'Pengolahan Sampah', 'Bak sampah rusak menyebabkan tumpukan sampah plastik dan sisa makanan berserakan', '{\"jenis_limbah\": [\"Sampah organik sisa makanan\", \"Kemasan plastik\"], \"potensi_vektor\": \"Lalat dan kucing liar\", \"tingkat_urgensi\": \"Sedang\", \"volume_estimasi\": \"3 bak sampah besar\", \"kategori_fasilitas\": \"Pengolahan Sampah\", \"kondisi_kebersihan\": \"Menumpuk dan Berbau\", \"tindakan_dibutuhkan\": \"Pengangkutan sampah berkala dan penggantian bak sampah rusak\"}', 'Area Terbuka Belakang Gedung B', NULL, '2026-11-01 20:40:27', 'selesai'),
(4, 2, 'Sanitasi Toilet', 'Wastafel toilet wanita gedung rektorat bocor menimbulkan becek di lantai', '{\"pasokan_air\": \"Mengalir Lemah\", \"fasilitas_rusak\": [\"Pipa pembuangan wastafel bocor\"], \"tingkat_urgensi\": \"Sedang\", \"kategori_fasilitas\": \"Sanitasi & Toilet\", \"kondisi_kebersihan\": \"Cukup Bersih\", \"tindakan_dibutuhkan\": \"Penggantian pipa siphon wastafel\"}', 'Gedung Rektorat Lantai 1', NULL, '2026-11-01 20:40:27', 'menunggu'),
(5, 2, 'Drainase Lingkungan', 'Saluran drainase depan lab TRPL tersumbat sampah dan endapan lumpur berbau busuk', '{\"genangan_air\": true, \"potensi_vektor\": \"Jentik nyamuk demam berdarah (DBD)\", \"tingkat_urgensi\": \"Tinggi\", \"kategori_fasilitas\": \"Drainase & Lingkungan\", \"kondisi_kebersihan\": \"Tersumbat Lumpur & Sampah\", \"tindakan_dibutuhkan\": \"Pembersihan got drainase dan penaburan bubuk larvasida\"}', 'Depan Gedung Laboratorium TRPL', NULL, '2026-11-01 20:40:27', 'diproses'),
(6, 3, 'Fasilitas Kebersihan', 'Tempat cuci tangan lantai 2 perpustakaan tidak ada sabun dan tisu pengering', '{\"tingkat_urgensi\": \"Rendah\", \"kategori_fasilitas\": \"Fasilitas Kebersihan\", \"kondisi_kebersihan\": \"Bersih\", \"perlengkapan_kurang\": [\"Sabun cair cuci tangan\", \"Tisu pengering\"], \"tindakan_dibutuhkan\": \"Pengisian ulang sabun cuci tangan dan tisu\"}', 'Gedung Perpustakaan Pusat Lantai 2', NULL, '2026-11-01 20:40:27', 'menunggu'),
(11, 5, 'Sanitasi Toilet', 'Kloset toilet asrama mahasiswa tersumbat parah dan air limbah meluap ke koridor', '{\"pasokan_air\": \"Mengalir Normal\", \"fasilitas_rusak\": [\"Kloset tersumbat parah\"], \"tingkat_urgensi\": \"Tinggi\", \"kategori_fasilitas\": \"Sanitasi & Toilet\", \"kondisi_kebersihan\": \"Sangat Kotor / Meluap\", \"tindakan_dibutuhkan\": \"Pembersihan darurat dan penanganan pipa sedot WC\"}', 'Gedung Asrama Mahasiswa Blok A', NULL, '2026-11-10 02:27:57', 'menunggu'),
(13, 1, 'Kualitas Ruangan', 'Ruang kelas 301 berdebu tebal dan filter AC kotor berjamur menimbulkan bau apek', '{\"filter_ac\": \"Berjamur dan kotor\", \"tingkat_urgensi\": \"Sedang\", \"gangguan_kesehatan\": \"Memicu bersin dan alergi mahasiswa\", \"kategori_fasilitas\": \"Kualitas Ruangan\", \"kondisi_kebersihan\": \"Berdebu dan Lembab\", \"tindakan_dibutuhkan\": \"Service cuci AC dan pembersihan ruangan secara menyeluruh\"}', 'Gedung Kuliah Lantai 3 Ruang 301', NULL, '2026-11-13 14:14:14', 'menunggu');

-- --------------------------------------------------------

--
-- Table structure for table `notifikasi`
--

CREATE TABLE `notifikasi` (
  `id_notifikasi` int NOT NULL,
  `id_pengguna` int NOT NULL,
  `id_laporan` int DEFAULT NULL,
  `judul_notifikasi` varchar(200) NOT NULL,
  `isi_notifikasi` text,
  `tanggal_dibuat` datetime DEFAULT CURRENT_TIMESTAMP,
  `status_baca` enum('belum_dibaca','sudah_dibaca') DEFAULT 'belum_dibaca'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE `pengguna` (
  `id_pengguna` int NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nim_nip` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL,
  `peran` enum('mahasiswa','petugas','admin') NOT NULL,
  `tanggal_daftar` datetime DEFAULT CURRENT_TIMESTAMP,
  `total_laporan` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pengguna`
--

INSERT INTO `pengguna` (`id_pengguna`, `nama`, `email`, `nim_nip`, `password`, `peran`, `tanggal_daftar`, `total_laporan`) VALUES
(1, 'Andi', 'andi@gmail.com', '2301001', '12345', 'mahasiswa', '2026-11-01 20:40:27', 3),
(2, 'Budi', 'budi@gmail.com', '2301002', '12345', 'mahasiswa', '2026-11-01 20:40:27', 2),
(3, 'Citra', 'citra@gmail.com', '2301003', '12345', 'mahasiswa', '2026-11-01 20:40:27', 1),
(4, 'Admin', 'admin@gmail.com', 'ADM001', '12345', 'admin', '2026-11-01 20:40:27', 0),
(5, 'Doni', 'doni@gmail.com', '2301004', '12345', 'mahasiswa', '2026-11-10 01:47:17', 0);

-- --------------------------------------------------------

--
-- Table structure for table `riwayat_status_laporan`
--

CREATE TABLE `riwayat_status_laporan` (
  `id_riwayat` int NOT NULL,
  `id_laporan` int NOT NULL,
  `id_pengguna` int NOT NULL,
  `status_sebelumnya` varchar(50) DEFAULT NULL,
  `status_baru` varchar(50) NOT NULL,
  `tanggal_perubahan` datetime DEFAULT CURRENT_TIMESTAMP,
  `catatan` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `riwayat_status_laporan`
--

INSERT INTO `riwayat_status_laporan` (`id_riwayat`, `id_laporan`, `id_pengguna`, `status_sebelumnya`, `status_baru`, `tanggal_perubahan`, `catatan`) VALUES
(212, 1, 1, 'menunggu', 'diproses', '2026-11-02 15:50:57', 'Petugas kebersihan dan teknisi pipa air sedang menuju lokasi toilet Gedung Kuliah Lt 2'),
(234, 2, 1, 'diproses', 'selesai', '2026-11-02 15:55:59', 'Pembersihan stan kantin dan penyemprotan lalat telah selesai dilaksanakan oleh tim kebersihan'),
(255, 3, 2, 'menunggu', 'diproses', '2026-11-03 15:50:57', 'Petugas kebersihan kampus sedang melakukan pengangkutan tumpukan sampah ke TPS utama'),
(256, 4, 2, 'diproses', 'selesai', '2026-11-03 15:55:59', 'Perbaikan pipa saluran pembuangan wastafel toilet rektorat telah rampung dan tidak bocor lagi'),
(257, 5, 3, 'menunggu', 'selesai', '2026-12-04 15:50:57', 'Pengerukan endapan lumpur got dan pembersihan sampah plastik drainase telah tuntas'),
(258, 6, 3, 'menunggu', 'selesai', '2026-12-04 15:55:59', 'Pengisian ulang sabun cuci tangan dan tisu pada wastafel perpustakaan telah selesai dilakukan');

-- --------------------------------------------------------

--
-- Table structure for table `tindak_lanjut`
--

CREATE TABLE `tindak_lanjut` (
  `id_tindak_lanjut` int NOT NULL,
  `id_laporan` int NOT NULL,
  `id_petugas` int NOT NULL,
  `tanggal_penanganan` datetime DEFAULT NULL,
  `catatan_perbaikan` text,
  `status_akhir` enum('selesai','belum_selesai') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `verifikasi_laporan`
--

CREATE TABLE `verifikasi_laporan` (
  `id_verifikasi` int NOT NULL,
  `id_laporan` int NOT NULL,
  `id_admin` int NOT NULL,
  `tanggal_verifikasi` datetime DEFAULT CURRENT_TIMESTAMP,
  `hasil_verifikasi` enum('disetujui','ditolak') NOT NULL,
  `catatan_verifikasi` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `verifikasi_laporan`
--

INSERT INTO `verifikasi_laporan` (`id_verifikasi`, `id_laporan`, `id_admin`, `tanggal_verifikasi`, `hasil_verifikasi`, `catatan_verifikasi`) VALUES
(123456, 1, 4, '2026-11-02 15:50:43', 'disetujui', 'Laporan kerusakan fasilitas valid, telah dikoordinasikan ke tim sarana prasarana dan teknisi pipa'),
(345678, 2, 4, '2026-11-02 15:55:57', 'disetujui', 'Laporan higienitas valid, surat peringatan sanitasi diterbitkan untuk pengelola stan kantin 03'),
(543326, 3, 4, '2026-12-04 15:50:57', 'disetujui', 'Titik tumpukan sampah diverifikasi, pengangkutan sampah ke TPS utama kampus dijadwalkan sore ini'),
(543327, 4, 4, '2026-11-03 15:54:00', 'disetujui', 'Laporan wastafel bocor diverifikasi, suku cadang pipa pengganti telah disiapkan bagian logistik'),
(543328, 5, 4, '2026-11-04 15:52:00', 'disetujui', 'Laporan selokan tersumbat valid, tim sanitasi lingkungan dijadwalkan melakukan pengerukan lumpur got'),
(543329, 6, 4, '2026-11-04 15:54:00', 'disetujui', 'Laporan fasilitas kebersihan diverifikasi, logistik sabun cair dan tisu telah disetujui untuk di-refill');

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
  ADD KEY `idx_status_laporan` (`status`),
  ADD KEY `idx_id_pengguna` (`id_pengguna`);

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
  MODIFY `id_laporan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
