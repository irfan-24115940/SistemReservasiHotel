-- =============================================================================
-- LAPORAN UAS PEMROGRAMAN BASIS DATA - SISTEM RESERVASI HOTEL
-- Database Engine: PostgreSQL
-- Author: M. Irfan Amelianso, M. Dhani Favian, Sultan Syekhu Aly Wafa, Andika Cavello B.
-- Universitas Amikom Yogyakarta (2025)
-- =============================================================================

-- =============================================================================
-- BAB 2: DDL & SEEDING DATA UTAMA
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 2.2 Kode DDL (Data Definition Language)
-- -----------------------------------------------------------------------------

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

-- 8. Tabel Log Aktivitas (Audit)
CREATE TABLE log_aktivitas (
    id_log SERIAL PRIMARY KEY,
    aktivitas VARCHAR(255) NOT NULL,
    waktu TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- -----------------------------------------------------------------------------
-- 2.3 Pengisian Data Awal (Seeding Initial Data)
-- -----------------------------------------------------------------------------

-- Seeding Tabel Tamu (10 Data)
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

-- Seeding Tabel Profil Tamu (10 Data Relasi 1:1)
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
('Superior', 500000.00),
('Deluxe', 850000.00),
('Presidential Suite', 2500000.00);

-- Seeding Tabel Kamar (10 Data)
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

-- Seeding Tabel Reservasi (10 Data)
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
('Breakfast Buffet', 75000.00),
('Airport Shuttle', 150000.00),
('Spa & Massage', 250000.00),
('Extra Bed', 100000.00);

-- Seeding Tabel Detail Layanan Reservasi (10 Data)
INSERT INTO detail_layanan_reservasi (id_reservasi, id_layanan, jumlah, subtotal) VALUES
(1, 2, 2, 150000),
(1, 3, 1, 150000),
(2, 1, 1, 50000),
(3, 4, 2, 500000),
(3, 5, 1, 100000),
(4, 2, 2, 150000),
(6, 3, 1, 150000),
(6, 4, 1, 250000),
(7, 1, 2, 100000),
(8, 2, 1, 75000);


-- -----------------------------------------------------------------------------
-- 2.4 Generating Data Jumlah Besar (Uji Indexing - 5.000 Data Kamar)
-- -----------------------------------------------------------------------------
INSERT INTO kamar (id_tipe, nomor_kamar, status_kamar)
SELECT 
    t.id_tipe,
    'KM-' || gs,
    CASE 
        WHEN random() > 0.6 THEN 'Tersedia'
        WHEN random() > 0.3 THEN 'Terisi'
        ELSE 'Pemeliharaan'
    END
FROM generate_series(1, 5000) AS gs
CROSS JOIN LATERAL (
    SELECT id_tipe FROM tipe_kamar ORDER BY random() LIMIT 1
) AS t;

-- Verifikasi Total Baris
SELECT COUNT(*) FROM kamar;


-- =============================================================================
-- BAB 3: IMPLEMENTASI POSTGRESQL OBJECTS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 3.1 FUNCTION
-- -----------------------------------------------------------------------------

-- Function 1: Tanpa Parameter (Menghitung Total Kamar Tersedia)
CREATE OR REPLACE FUNCTION fn_total_kamar_tersedia()
RETURNS INT
LANGUAGE plpgsql AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total FROM kamar WHERE status_kamar = 'Tersedia';
    RETURN total;
END;
$$;

-- Function 2: Dengan 2 Parameter (Harga per Malam & Durasi Menginap)
DROP FUNCTION IF EXISTS fn_hitung_biaya_menginap(NUMERIC, INT);

CREATE FUNCTION fn_hitung_biaya_menginap(
    p_harga NUMERIC,
    p_malam INT
)
RETURNS NUMERIC
LANGUAGE plpgsql AS $$
BEGIN
    RETURN p_harga * p_malam;
END;
$$;

-- Eksekusi Function 2 dengan JOIN 2 Tabel
SELECT 
    k.nomor_kamar,
    tk.nama_tipe,
    tk.harga_per_malam,
    fn_hitung_biaya_menginap(tk.harga_per_malam, 3) AS estimasi_3_malam
FROM kamar k
JOIN tipe_kamar tk ON k.id_tipe = tk.id_tipe
LIMIT 5;

-- Eksekusi Function 1 menggunakan Subquery
SELECT 
    nama_tipe,
    (SELECT fn_total_kamar_tersedia()) AS total_kamar_siap_huni
FROM tipe_kamar;

-- Tampilkan Daftar Function
SELECT 
    routine_name AS nama_function
FROM information_schema.routines
WHERE routine_type = 'FUNCTION' 
  AND routine_schema = 'public'
ORDER BY routine_name;


-- -----------------------------------------------------------------------------
-- 3.2 STORED PROCEDURE
-- -----------------------------------------------------------------------------

-- Procedure 1: Memakai CURSOR & Control Flow IF (Audit Kamar Pemeliharaan)
CREATE OR REPLACE PROCEDURE sp_audit_kamar_pemeliharaan()
LANGUAGE plpgsql AS $$
DECLARE
    v_nomor VARCHAR(10);
    v_status VARCHAR(20);
    cur_kamar CURSOR FOR SELECT nomor_kamar, status_kamar FROM kamar;
BEGIN
    OPEN cur_kamar;
    LOOP
        FETCH cur_kamar INTO v_nomor, v_status;
        EXIT WHEN NOT FOUND;
        IF v_status = 'Pemeliharaan' THEN
            INSERT INTO log_aktivitas (aktivitas)
            VALUES ('PERINGATAN: Kamar Nomor ' || v_nomor || ' butuh perbaikan teknis!');
        END IF;
    END LOOP;
    CLOSE cur_kamar;
END;
$$;

-- Procedure 2: Parameter INOUT, CURSOR & Control Flow CASE (Hitung Total Reservasi + Diskon VIP)
CREATE OR REPLACE PROCEDURE sp_hitung_total_reservasi_tamu(
    p_id_tamu INT,
    INOUT p_total_akhir NUMERIC DEFAULT 0
)
LANGUAGE plpgsql AS $$
DECLARE
    v_biaya NUMERIC;
    v_total_sementara NUMERIC := 0;
    v_status_member VARCHAR(20);
    cur_reservasi CURSOR FOR 
        SELECT total_biaya FROM reservasi 
        WHERE id_tamu = p_id_tamu AND status_reservasi = 'Completed';
BEGIN
    SELECT status_member INTO v_status_member FROM tamu WHERE id_tamu = p_id_tamu;
    
    OPEN cur_reservasi;
    LOOP
        FETCH cur_reservasi INTO v_biaya;
        EXIT WHEN NOT FOUND;
        v_total_sementara := v_total_sementara + v_biaya;
    END LOOP;
    CLOSE cur_reservasi;
    
    CASE v_status_member
        WHEN 'VIP' THEN
            p_total_akhir := v_total_sementara * 0.90;
        ELSE
            p_total_akhir := v_total_sementara;
    END CASE;
END;
$$;

-- Eksekusi Stored Procedure
CALL sp_audit_kamar_pemeliharaan();
CALL sp_hitung_total_reservasi_tamu(1, 0);

-- Tampilkan Daftar Stored Procedure
SELECT 
    routine_name AS nama_procedure
FROM information_schema.routines
WHERE routine_type = 'PROCEDURE' 
  AND routine_schema = 'public'
ORDER BY routine_name;


-- -----------------------------------------------------------------------------
-- 3.3 TRIGGER
-- -----------------------------------------------------------------------------

-- Trigger 1: AFTER INSERT ON reservasi (Otomatis Mengubah Status Kamar Menjadi 'Terisi')
CREATE OR REPLACE FUNCTION fn_trg_update_status_kamar()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    UPDATE kamar SET status_kamar = 'Terisi' WHERE id_kamar = NEW.id_kamar;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_update_status_kamar_after_reservasi
AFTER INSERT ON reservasi
FOR EACH ROW EXECUTE FUNCTION fn_trg_update_status_kamar();

-- Trigger 2: BEFORE UPDATE ON tamu (Log Audit Otomatis Perubahan Email)
CREATE OR REPLACE FUNCTION fn_trg_log_email_tamu()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF OLD.email <> NEW.email THEN
        INSERT INTO log_aktivitas (aktivitas)
        VALUES ('Tamu ID ' || OLD.id_tamu || ' merubah email dari ' || OLD.email || ' ke ' || NEW.email);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_log_perubahan_email_tamu
BEFORE UPDATE ON tamu
FOR EACH ROW EXECUTE FUNCTION fn_trg_log_email_tamu();

-- Pengujian Trigger 2
UPDATE tamu SET email = 'budi_baru2026@gmail.com' WHERE id_tamu = 1;
SELECT * FROM log_aktivitas;

-- Tampilkan Daftar Trigger
SELECT 
    trigger_name AS nama_trigger,
    event_object_table AS nama_tabel,
    event_manipulation AS event
FROM information_schema.triggers
WHERE trigger_schema = 'public'
ORDER BY trigger_name;


-- -----------------------------------------------------------------------------
-- 3.4 INDEX
-- -----------------------------------------------------------------------------

-- Metode 1: Composite Index via CREATE TABLE (Composite PRIMARY KEY)
-- Terimplementasi otomatis pada detail_layanan_reservasi(id_reservasi, id_layanan)

-- Metode 2: Composite Index via Perintah CREATE INDEX
CREATE INDEX idx_tipe_status ON kamar (id_tipe, status_kamar);

-- Metode 3: Composite Index via ALTER TABLE UNIQUE Constraint
ALTER TABLE reservasi ADD CONSTRAINT unique_tamu_checkin UNIQUE (id_tamu, tgl_checkin);

-- Pengujian Query 1: Menggunakan Composite Index (Index Scan)
EXPLAIN ANALYZE SELECT * FROM kamar WHERE id_tipe = 2 AND status_kamar = 'Tersedia';

-- Pengujian Query 2: Tanpa Index (Sequential Scan)
EXPLAIN ANALYZE SELECT * FROM kamar WHERE nomor_kamar LIKE '%KM-2500%';

-- Tampilkan Daftar Index
SELECT 
    indexname AS nama_index,
    tablename AS nama_tabel,
    indexdef AS definisi_index
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;


-- -----------------------------------------------------------------------------
-- 3.5 VIEW
-- -----------------------------------------------------------------------------

-- Horizontal View (Filter Berdasarkan Baris Status Completed)
CREATE VIEW v_reservasi_selesai AS 
SELECT * FROM reservasi WHERE status_reservasi = 'Completed';

-- Vertical View (Filter Berdasarkan Kolom Spesifik Kontak Tamu)
CREATE VIEW v_kontak_tamu AS 
SELECT id_tamu, nama_lengkap, email FROM tamu;

-- View Inside View (Nested View) dengan WITH CASCADED CHECK OPTION
CREATE VIEW v_kamar_tersedia AS
SELECT * FROM kamar
WHERE status_kamar = 'Tersedia'
WITH CASCADED CHECK OPTION;

CREATE VIEW v_kamar_tersedia_lantai1 AS
SELECT * FROM v_kamar_tersedia
WHERE nomor_kamar LIKE 'K1%'
WITH CASCADED CHECK OPTION;

-- Manipulasi Data DML Melalui View (UPDATE)
UPDATE v_reservasi_selesai SET total_biaya = 1200000 WHERE id_reservasi = 1;
SELECT * FROM v_reservasi_selesai WHERE id_reservasi = 1;

-- Manipulasi Data DML Melalui View (INSERT)
INSERT INTO v_kontak_tamu (id_tamu, nama_lengkap, email)
VALUES (11, 'Budi Santoso', 'budi.santoso@email.com');
SELECT * FROM v_kontak_tamu WHERE id_tamu = 11;

-- Tampilkan Daftar View
SELECT table_name AS nama_view
FROM information_schema.views
WHERE table_schema = 'public'
ORDER BY table_name;


-- -----------------------------------------------------------------------------
-- 3.6 DATABASE SECURITY (ROLE & PRIVILEGES)
-- -----------------------------------------------------------------------------

-- 1. Buat 3 Role Group
CREATE ROLE role_admin;
CREATE ROLE role_resepsionis;
CREATE ROLE role_analis;

-- 2. Buat 3 User Login
CREATE ROLE user_admin WITH LOGIN PASSWORD 'AdminPass123!';
CREATE ROLE user_resepsionis WITH LOGIN PASSWORD 'ResepsionisPass123!';
CREATE ROLE user_analis WITH LOGIN PASSWORD 'AnalisPass123!';

-- 3. Pembagian Hak Akses (Privileges)
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO role_admin;
GRANT SELECT, INSERT, UPDATE ON TABLE reservasi TO role_resepsionis;
GRANT SELECT ON TABLE v_reservasi_selesai TO role_analis;

-- 4. Inisialisasi Role Group ke User
GRANT role_admin TO user_admin;
GRANT role_resepsionis TO user_resepsionis;
GRANT role_analis TO user_analis;

-- 5. Query Verifikasi Privileges
SELECT grantee, privilege_type, table_name
FROM information_schema.role_table_grants
WHERE grantee IN ('role_admin', 'role_resepsionis', 'role_analis');
