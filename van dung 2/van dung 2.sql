USE my2;

-- 1. Cau truc bang ban dau
CREATE TABLE SHIPPERS (
	ShipperID INT PRIMARY KEY AUTO_INCREMENT,
	ShipperName VARCHAR(255),
	Phone VARCHAR(20)
);
-- - 2. DÒNG LỆNH LÔI 1: Hệ thông báo "Syntax Error"
-- Hãy tìm xem dầu nháy đơn đang bị thiêu ở đâu?
-- INSERT INTO SHIPPERS (ShipperName, Phone)
-- VALUES ('Giao Hang Nhanh, '0901234567' );

-- 3. DÒNG LỆNH LÔI 2: Hệ thông chạy được nhưng dữ liệu bị
-- "Kẹt" (Thieu thong tin)
-- Tại sao cột Phone lại bị NULL trong trường hợp này?

-- INSERT INTO SHIPPERS
-- VALUES ('Viettel Post' );

-- Giải 
-- Chỉ ra 2 lỗi sai 
-- lỗi 1  " VALUES ('Giao Hang Nhanh, '0901234567' );" không đóng ' cho shipperName làm lỗi không chạy đuợc 
-- lỗi 2  "INSERT INTO SHIPPERS VALUES ('Viettel Post' );" thì ko lỗi cú pháp và không có phone 

-- viết lại code 

INSERT INTO SHIPPERS (ShipperName, Phone)
VALUES ('Giao Hang Nhanh', '0901234567');

INSERT INTO SHIPPERS (ShipperName, Phone)
VALUES ('Viettel Post', '0123456789');


