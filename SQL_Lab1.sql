
USE Sales
-- 1. Kiểu dữ liệu tự định nghĩa
EXEC sp_addtype Mota, 'NVARCHAR(40)', 'NULL';
EXEC sp_addtype IDKH, 'CHAR(10)', 'NOT NULL';
EXEC sp_addtype DT, 'CHAR(12)', 'NOT NULL';
-- 2. Tạo table
CREATE TABLE SanPham (
MaSP CHAR(6) NOT NULL,
TenSP VARCHAR(20),
NgayNhap Date,
DVT CHAR(10),
SoLuongTon INT,
DonGiaNhap money,
)
CREATE TABLE HoaDon (
MaHD CHAR(10) NOT NULL,
NgayLap Date,
NgayGiao Date,
MaKH IDKH,
DienGiai Mota,
)
CREATE TABLE KhachHang (
MaKH IDKH,
TenKH NVARCHAR(30),
DiaCHi NVARCHAR(40),
DienThoai DT,
)
CREATE TABLE ChiTietHD (
MaHD CHAR(10) NOT NULL,
MaSP CHAR(6) NOT NULL,
SoLuong INT
)

-- 3. Trong Table HoaDon, sửa cột DienGiai thành nvarchar(100).
ALTER TABLE HoaDon
ALTER COLUMN DienGiai NVARCHAR(100)
-- 4. Thêm vào bảng SanPham cột TyLeHoaHong float
ALTER TABLE SanPham
ADD TyLeHoaHong float
-- 5. Xóa cột NgayNhap trong bảng SanPham
ALTER TABLE SanPham
DROP COLUMN NgayNhap
--6.Tạo các ràng buộc khóa chính và khóa ngoại cho các bảng trên
ALTER TABLE SanPham
ADD
CONSTRAINT pk_sp primary key(MASP)

ALTER TABLE HoaDon
ADD
CONSTRAINT pk_hd primary key(MaHD)

ALTER TABLE KhachHang
ADD
CONSTRAINT pk_khanghang primary key(MaKH)

ALTER TABLE HoaDon
ADD
CONSTRAINT fk_khachhang_hoadon FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH)

ALTER TABLE ChiTietHD
ADD
CONSTRAINT fk_hoadon_chitiethd FOREIGN KEY(MaHD) REFERENCES HoaDon(MaHD)

ALTER TABLE ChiTietHD
ADD
CONSTRAINT fk_sanpham_chitiethd FOREIGN KEY(MaSP) REFERENCES SanPham(MaSP)
--7.Thêm vào bảng hóa đơn các ràng buộc
--NgayGiao >= NgayLap
ALTER TABLE HoaDon
ADD CHECK (NgayGiao >= NgayLap)
--MaHD gồm 6 ký tự, 2 ký tự đầu là chữ, các ký tự còn lại là số
ALTER TABLE HoaDon
ADD CHECK (MaHD like '[A-Z][A-Z][0-9][0-9][0-9][0-9]')
--Giá trị mặc định cột NgayLap luôn là ngày hiện hành
ALTER TABLE HoaDon
ADD DEFAULT(getdate()) FOR NgayLap;
--8.Thêm vào bảng Sản phẩm các ràng buộc:
ALTER TABLE SanPham
ADD CHECK (SoLuongTon > 0 and SoLuongTon < 50)

ALTER TABLE SanPham
ADD CHECK (DonGiaNhap > 0)

ALTER TABLE SanPham
ADD CONSTRAINT df_ngaynhap DEFAULT GETDATE() FOR NgayNhap

ALTER TABLE SanPham
ADD CHECK (DVT like 'KG''Thùng''Hộp''Cái')
--9.Dùng lệnh T-SQL nhập dữ liệu vào 4 table trên, dữ liệu tùy ý, chú ý các ràng buộc của mỗi Table
INSERT INTO SanPham
VALUES ('sp01', 'ss10note', 'đồng', 10, 2000000,0.5),
		('sp02', 'iporn', 'đồng', 12, 3000000,0.5),
		('sp03', 'appleX', 'đồng', 150, 3000000,0.5),
		('sp04', 'smarttv', 'đồng', 20, 4000000,0.5),
		('sp05', 'realme', 'đồng', 25, 4000000,0.5);
insert into KhachHang
values ('kh01', 'Quang', 'Vietnam', 21345633),
		('kh02', 'Lâm', 'Vietnam', 1234642),
		('kh03', 'Hào', 'Vietnam', 12455674),
		('kh04', 'Kiệt', 'Vietnam', 52156123);
insert into HoaDon
values  ('hd01', '2023/2/15','2023/2/30','kh01','.'),
		('hd02', '2023/3/15','2023/3/30','kh02','.'),
		('hd03', '2023/4/15','2023/4/30','kh03','.'),
		('hd04', '2023/5/15','2023/5/30','kh04','.');
insert into ChiTietHD
values ('hd01','sp01', 1),
		('hd02','sp02', 2),
		('hd03','sp03', 1),
		('hd04','sp04', 2);

--12.Đổi tên database
ALTER DATABASE Sales SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
ALTER DATABASE Sales MODIFY NAME = BanHang;

