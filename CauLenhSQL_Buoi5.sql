--18. Cho biết số lượng đề án của công ty
select count(*)
from dean
--19. Liệt kê danh sách các phòng ban có tham gia chủ trì các đề án
select PHONGBAN.TENPHG, COUNT(DEAN.PHONG) as 'Số lượng đề án'
from PHONGBAN, DEAN
where PHONGBAN.MAPHG = DEAN.PHONG
group by PHONGBAN.TENPHG
--20. Cho biết số lượng các phòng ban có tham gia chủ trì các đề án
select TENPHG,count(*)
from PHONGBAN,DEAN
where maphg=phong
group by TENPHG
select *
from DEAN
--21. Cho biết số lượng đề án do phòng Nghiên Cứu chủ trì
Select count(*)
from PHONGBAN,DEAN
where PHONG=MAPHG and TENPHG like N'Nghiên cứu'
select *
from dean
select *
from PHANCONG
select*
from NHANVIEN
--22. Cho biết lương trung bình của các nữ nhân viên
select avg(LUONG) as 'Lương Trung Bình của các NV nữ'
from NHANVIEN
where phai like N'Nữ'
--23. Cho biết số thân nhân của nhân viên Đinh Bá Tiến
select count(*) as 'Số thân nhân của tiến'
from NHANVIEN,THANNHAN
where MANV=MA_NVIEN and HONV = N'Đinh' and TENLOT=N'Bá' and TENNV=N'Tiến'
--24. Liệt kê danh sách 3 nhân viên lớn tuổi nhất, danh sách bao gồm họ tên và năm sinh.
select top (3) HONV+' '+TENLOT+' '+TENNV as 'Họ Và Tên', max(YEAR(NGSINH)) as 'Năm sinh' from NHANVIEN
group by HONV, TENLOT, TENNV
--25. Với mỗi đề án, liệt kê mã đề án và tổng số giờ làm việc của tất cả các nhân viên tham gia đề án đó.
select DEAN.MADA,sum(THOIGIAN) as 'Tổng số giờ làm việc'
from DEAN,PHANCONG
where dean.MADA = PHANCONG.MADA
group by DEAN.MADA
--26. Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc của tất cả các nhân viên tham gia đề án đó.
select TENDEAN,sum(THOIGIAN) as 'Tổng số giờ làm việc'
from DEAN,PHANCONG
where dean.MADA = PHANCONG.MADA
group by TENDEAN
--27. Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia đề án đó, thông tin bao gồm tên đề án và số lượng nhân viên.
select PHANCONG.MADA, count(*) as 'số lượng nhân viên'
from PHANCONG,NHANVIEN,DEAN
where MANV=MA_NVIEN
group by PHANCONG.MADA
--28. Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân của nhân viên đó.
select HONV+' '+TENNV as 'Họ Và Tên',count(*) as 'Số lượng thân nhân'
from NHANVIEN,THANNHAN
where MANV = MA_NVIEN
group by HONV,TENNV
--29. Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà nhân viên đó đã tham gia.
select honv,tennv,count(*)
from NHANVIEN,PHANCONG
where MANV=MA_NVIEN
group by honv,tennv
--30. Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó.
select TENPHG,AVG(LUONG)
from PHONGBAN,NHANVIEN
where maphg=PHG
group by TENPHG
--31. Với các phòng ban có mức lương trung bình trên 5.200.000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
select TENPHG,COUNT(*) as 'Số lượng nhân viên làm việc'
from PHONGBAN,NHANVIEN
where MAPHG=PHG
group by TENPHG
having avg(LUONG)>5200000
--32. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì
select TENPHG,count(*)
from PHONGBAN,DEAN
where maphg=phong
group by TENPHG
--33. Với mỗi phòng ban, cho biết tên phòng ban, họ tên người trưởng phòng và số lượng đề án mà phòng ban đó chủ trì
select TENPHG,HONV,TENLOT,TENNV,count(*) as 'Số lượng đề án'
from PHONGBAN,NHANVIEN,DEAN
where MANV=TRPHG and MAPHG=PHONG
group by TENPHG,HONV,TENLOT,TENNV
--34. Với mỗi đề án, cho biết tên đề án và số lượng nhân viên tham gia đề án
select DEAN.MADA,TENDEAN,count(*) as 'Số lượng nhân viên tham gia'
from DEAN,CONGVIEC
where DEAN.MADA=CONGVIEC.MADA
group by dean.MADA,TENDEAN