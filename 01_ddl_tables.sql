-- =============================================
-- 01. DATA DEFINITION LANGUAGE (DDL)
-- =============================================

-- 1. Tabel Master Tamu
CREATE TABLE tamu (
    id_tamu SERIAL PRIMARY KEY,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    status_member VARCHAR(20) DEFAULT 'Reguler' CHECK (status_member IN ('Reguler', 'VIP'))
);

-- 2. Tabel Profil Tamu (Relasi 1:1)
CREATE TABLE profil_tamu (
    id_tamu INT PRIMARY KEY REFERENCES tamu(id_tamu) ON DELETE CASCADE,
    no_nik VARCHAR(20) UNIQUE NOT NULL,
    no_telepon VARCHAR(15) NOT NULL,
    alamat TEXT NOT NULL
);

-- 3. Tabel Tipe Kamar
CREATE TABLE tipe_kamar (
    id_tipe SERIAL PRIMARY KEY,
    nama_tipe VARCHAR(50) NOT NULL,
    harga_per_malam NUMERIC(12,2) NOT NULL
);

-- 4. Tabel Kamar (Relasi 1:N dari Tipe Kamar)
CREATE TABLE kamar (
    id_kamar SERIAL PRIMARY KEY,
    id_tipe INT NOT NULL REFERENCES tipe_kamar(id_tipe) ON DELETE CASCADE,
    nomor_kamar VARCHAR(10) NOT NULL,
    status_kamar VARCHAR(20) DEFAULT 'Tersedia' CHECK (status_kamar IN ('Tersedia', 'Terisi', 'Pemeliharaan'))
);

-- 5. Tabel Reservasi (Relasi 1:N)
CREATE TABLE reservasi (
    id_reservasi SERIAL PRIMARY KEY,
    id_tamu INT NOT NULL REFERENCES tamu(id_tamu) ON DELETE CASCADE,
    id_kamar INT NOT NULL REFERENCES kamar(id_kamar) ON DELETE CASCADE,
    tgl_checkin DATE NOT NULL,
    tgl_checkout DATE NOT NULL,
    total_biaya NUMERIC(12,2) DEFAULT 0,
    status_reservasi VARCHAR(20) DEFAULT 'Pending' CHECK (status_reservasi IN ('Pending', 'Confirmed', 'Checked_In', 'Completed', 'Cancelled'))
);

-- 6. Tabel Layanan Master
CREATE TABLE layanan (
    id_layanan SERIAL PRIMARY KEY,
    nama_layanan VARCHAR(100) NOT NULL,
    harga NUMERIC(12,2) NOT NULL
);

-- 7. Tabel Detail Layanan (Relasi N:M Composite Key)
CREATE TABLE detail_layanan_reservasi (
    id_reservasi INT NOT NULL REFERENCES reservasi(id_reservasi) ON DELETE CASCADE,
    id_layanan INT NOT NULL REFERENCES layanan(id_layanan) ON DELETE CASCADE,
    jumlah INT NOT NULL,
    subtotal NUMERIC(12,2) NOT NULL,
    PRIMARY KEY (id_reservasi, id_layanan)
);

-- 8. Tabel Log Aktivitas
CREATE TABLE log_aktivitas (
    id_log SERIAL PRIMARY KEY,
    aktivitas VARCHAR(255) NOT NULL,
    waktu TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);