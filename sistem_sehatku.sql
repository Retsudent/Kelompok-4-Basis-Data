-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 01, 2026 at 02:53 PM
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
  `lokasi` varchar(150) DEFAULT NULL,
  `waktu_kejadian` datetime DEFAULT NULL,
  `tanggal_laporan` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('menunggu','diproses','selesai','ditolak') DEFAULT 'menunggu'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `laporan_keluhan`
--

INSERT INTO `laporan_keluhan` (`id_laporan`, `id_pengguna`, `jenis_keluhan`, `deskripsi`, `lokasi`, `waktu_kejadian`, `tanggal_laporan`, `status`) VALUES
(1, 1, 'Demam', 'Mengalami demam', 'Asrama A', NULL, '2026-11-01 20:40:27', 'menunggu'),
(2, 1, 'Batuk', 'Mengalami batuk', 'Asrama A', NULL, '2026-11-01 20:40:27', 'diproses'),
(3, 1, 'Pusing', 'Mengalami pusing', 'Kampus', NULL, '2026-11-01 20:40:27', 'selesai'),
(4, 2, 'Flu', 'Mengalami flu', 'Asrama B', NULL, '2026-11-01 20:40:27', 'menunggu'),
(5, 2, 'Sakit Perut', 'Mengalami sakit perut', 'Kampus', NULL, '2026-11-01 20:40:27', 'diproses'),
(6, 3, 'Alergi', 'Mengalami alergi', 'Asrama C', NULL, '2026-11-01 20:40:27', 'menunggu');

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
(4, 'Admin', 'admin@gmail.com', 'ADM001', '12345', 'admin', '2026-11-01 20:40:27', 0);

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
  ADD KEY `fk_laporan_pengguna` (`id_pengguna`);

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
  MODIFY `id_laporan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `notifikasi`
--
ALTER TABLE `notifikasi`
  MODIFY `id_notifikasi` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id_pengguna` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `riwayat_status_laporan`
--
ALTER TABLE `riwayat_status_laporan`
  MODIFY `id_riwayat` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tindak_lanjut`
--
ALTER TABLE `tindak_lanjut`
  MODIFY `id_tindak_lanjut` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `verifikasi_laporan`
--
ALTER TABLE `verifikasi_laporan`
  MODIFY `id_verifikasi` int NOT NULL AUTO_INCREMENT;

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
