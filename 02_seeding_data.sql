-- =============================================
-- 02. INITIAL SEEDING DATA
-- =============================================

-- Seeding Tabel Tamu
INSERT INTO tamu (nama_lengkap, email, status_member) VALUES
('Budi Santoso', 'budi@gmail.com', 'VIP'),
('Siti Aminah', 'siti@gmail.com', 'Reguler'),
('Ahmad Ridwan', 'ahmad@gmail.com', 'VIP'),
('Dewi Lestari', 'dewi@gmail.com', 'Reguler'),
('Eko Prasetyo', 'eko@gmail.com', 'Reguler'),
('Fani Putri', 'fani@gmail.com', 'VIP'),
('Giri Hartono', 'giri@gmail.com', 'Reguler'),
('Hana Sofia', 'hana@gmail.com', 'VIP'),
('Irfan Zaky', 'irfan@gmail.com', 'Reguler'),
('Joko Widodo', 'joko@gmail.com', 'Reguler');

-- Seeding Tabel Profil Tamu (Relasi 1:1)
INSERT INTO profil_tamu (id_tamu, no_nik, no_telepon, alamat) VALUES
(1, '3404011234560001', '081234567890', 'Yogyakarta'),
(2, '3404011234560002', '081234567891', 'Sleman'),
(3, '3404011234560003', '081234567892', 'Bantul'),
(4, '3404011234560004', '081234567893', 'Solo'),
(5, '3404011234560005', '081234567894', 'Semarang'),
(6, '3404011234560006', '081234567895', 'Surakarta'),
(7, '3404011234560007', '081234567896', 'Magelang'),
(8, '3404011234560008', '081234567897', 'Klaten'),
(9, '3404011234560009', '081234567898', 'Wonogiri'),
(10, '3404011234560010', '081234567899', 'Purworejo');

-- Seeding Tabel Tipe Kamar
INSERT INTO tipe_kamar (nama_tipe, harga_per_malam) VALUES
('Standard', 350000.00),
('Standard Twin', 375000.00),
('Superior', 500000.00),
('Superior Twin', 525000.00),
('Deluxe', 850000.00),
('Deluxe Twin', 875000.00),
('Junior Suite', 1200000.00),
('Executive Suite', 1750000.00),
('Presidential Suite', 2500000.00),
('Royal Suite', 3500000.00);

-- Seeding Tabel Kamar
INSERT INTO kamar (id_tipe, nomor_kamar, status_kamar) VALUES
(1, 'K101', 'Tersedia'),
(1, 'K102', 'Terisi'), 
(1, 'K103', 'Tersedia'),
(2, 'K201', 'Terisi'), 
(2, 'K202', 'Pemeliharaan'), 
(2, 'K203', 'Tersedia'),
(3, 'K301', 'Terisi'), 
(3, 'K302', 'Tersedia'),
(4, 'K401', 'Tersedia'), 
(4, 'K402', 'Pemeliharaan');

-- Seeding Tabel Reservasi
INSERT INTO reservasi (id_tamu, id_kamar, tgl_checkin, tgl_checkout, total_biaya, status_reservasi) VALUES
(1, 4, '2026-06-01', '2026-06-03', 1000000, 'Completed'),
(2, 2, '2026-06-05', '2026-06-06', 350000, 'Completed'),
(3, 7, '2026-06-10', '2026-06-12', 1700000, 'Checked_In'),
(4, 1, '2026-06-15', '2026-06-17', 700000, 'Confirmed'),
(5, 3, '2026-06-20', '2026-06-21', 350000, 'Pending'),
(6, 9, '2026-07-01', '2026-07-02', 2500000, 'Confirmed'),
(7, 6, '2026-07-03', '2026-07-05', 1000000, 'Completed'),
(8, 8, '2026-07-10', '2026-07-11', 850000, 'Confirmed'),
(9, 1, '2026-07-12', '2026-07-14', 700000, 'Cancelled'),
(10, 4, '2026-07-15', '2026-07-17', 1000000, 'Pending');

-- Seeding Tabel Layanan
INSERT INTO layanan (nama_layanan, harga) VALUES
('Laundry Express', 50000.00),
('Laundry Reguler', 30000.00),
('Breakfast Buffet', 75000.00),
('Room Service', 60000.00),
('Airport Shuttle', 150000.00),
('Late Checkout', 100000.00),
('Spa & Massage', 250000.00),
('Extra Bed', 100000.00),
('Karaoke Room', 200000.00),
('City Tour', 300000.00);

-- Seeding Tabel Detail Layanan Reservasi
INSERT INTO detail_layanan_reservasi (id_reservasi, id_layanan, jumlah, subtotal) VALUES
(1, 2, 2, 150000), (1, 3, 1, 150000),
(2, 1, 1, 50000),
(3, 4, 2, 500000), (3, 5, 1, 100000),
(4, 2, 2, 150000),
(6, 3, 1, 150000), (6, 4, 1, 250000),
(7, 1, 2, 100000),
(8, 2, 1, 75000);