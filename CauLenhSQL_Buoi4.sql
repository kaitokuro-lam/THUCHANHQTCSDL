--1. Liệt kê danh sách tất cả các nhân viên
SELECT * FROM NHANVIEN
--2. Tìm các nhân viên làm việc ở phòng số 5
SELECT * FROM NHANVIEN WHERE PHG = 5
--3. Liệt kê họ tên và phòng làm việc các nhân viên có mức lương trên 6.000.000 đồng
SELECT HONV,TENNV,PHG FROM NHANVIEN WHERE LUONG > 6000000
--4. Tìm các nhân viên có mức lương trên 6.500.000 ở phòng 1 hoặc các nhân viên có mức lương trên 5.000.000 ở phòng 4
SELECT * FROM NHANVIEN WHERE LUONG > 6500000 AND PHG = 1 OR PHG = 4 AND LUONG > 5000000
--5. Cho biết họ tên đầy đủ của các nhân viên ở TP Quảng Ngãi
SELECT HONV + ' ' + TENLOT + ' ' + TENNV AS 'Họ Và Tên' FROM NHANVIEN WHERE DCHI LIKE N'%Quảng Ngãi'
--6. Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự N
SELECT HONV + ' ' + TENLOT + ' ' + TENNV AS 'Họ Và Tên' FROM NHANVIEN WHERE NHANVIEN.HONV LIKE N'N%'
--7. Cho biết ngày sinh và địa chỉ của nhân viên Cao Thanh Huyền
SELECT NGSINH,DCHI FROM NHANVIEN WHERE HONV = N'Cao' AND TENLOT=N'Thanh' AND TENNV=N'Huyền'
--8. Cho biết các nhân viên có năm sinh trong khoảng 1955 đến 1975
SELECT * FROM NHANVIEN WHERE Year(NGSINH) BETWEEN 1955 AND 1975
--9. Cho biết các nhân viên và năm sinh của nhân viên
SELECT TENNV,Year(NGSINH) AS 'Năm sinh' FROM NHANVIEN
--10. Cho biết họ tên và tuổi của tất cả các nhân viên
SELECT TENNV,Year(getdate())-Year(NGSINH) AS 'Tuổi' FROM NHANVIEN
--11. Tìm tên những người trưởng phòng của từng phòng ban
SELECT HONV + ' ' + TENLOT + ' ' + TENNV AS 'Họ Và Tên Trưởng Phòng' FROM PHONGBAN,NHANVIEN WHERE PHONGBAN.TRPHG=NHANVIEN.MANV
--12. Tìm tên và địa chỉ của tất cả các nhân viên của phòng "Điều hành"
SELECT TENNV,DCHI FROM PHONGBAN,NHANVIEN WHERE PHONGBAN.MAPHG = NHANVIEN.PHG AND TENPHG LIKE N'Điều hành'
--13. Với mỗi đề án ở Tp Quảng Ngãi, cho biết tên đề án, tên phòng ban, họ tên và ngày nhận chức của trưởng phòng của phòng ban chủ trì đề án đó
SELECT TENDEAN,TENPHG,HONV,TENNV 
FROM NHANVIEN,PHONGBAN,DEAN 
WHERE NHANVIEN.MANV = PHONGBAN.TRPHG AND PHONGBAN.MAPHG = DEAN.PHONG AND DEAN.DDIEM_DA LIKE N'Quảng Ngãi'
--14. Tìm tên những nữ nhân viên và tên người thân của họ
SELECT TENNV,TENTN
FROM NHANVIEN,THANNHAN
WHERE NHANVIEN.MANV = THANNHAN.MA_NVIEN AND NHANVIEN.PHAI LIKE N'Nữ'
--15. Với mỗi nhân viên, cho biết họ tên của nhân viên, họ tên trưởng phòng của phòng ban mà nhân viên đó đang làm việc
SELECT nv.HONV + ' ' + nv.TENLOT + ' ' + nv.TENNV AS 'Họ Và Tên nv',
	   tp.HONV + ' ' + tp.TENLOT + ' ' + tp.TENNV AS 'Họ Và Tên Trưởng Phòng'
FROM NHANVIEN nv,NHANVIEN ql,NHANVIEN tp , PHONGBAN pb
WHERE nv.MA_NQL=ql.MANV AND tp.MANV= pb.TRPHG AND pb.MAPHG=nv.PHG
--16. Tên những nhân viên phòng Nghiên cứu có tham gia vào đề án "Xây dựng nhà máy chế biến thủy sản"
SELECT nv.TENNV
FROM NHANVIEN nv, DEAN da
WHERE nv.PHG = da.PHONG AND nv.PHG = 5 AND da.TENDEAN LIKE N'Xây dựng nhà máy chế biến thủy sản'
--17. Cho biết tên các đề án mà nhân viên Trần Thanh Tâm đã tham gia
SELECT DEAN.TENDEAN
FROM NHANVIEN,PHANCONG,DEAN
WHERE NHANVIEN.MANV = PHANCONG.MA_NVIEN AND PHANCONG.MADA= DEAN.MADA AND HONV = N'Trần' AND TENLOT=N'Thanh' AND TENNV=N'Tâm'