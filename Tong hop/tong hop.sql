USE my2;

CREATE TABLE Products (
	ProductId CHAR(5) PRIMARY KEY,
    ProductName VARCHAR(100),
    Size CHAR(5),
    Price DECIMAL(18, 2)
);

INSERT INTO Products (ProductId, ProductName, Size, Price) VALUE 
('P01', 'Áo sơ mi trắng', 'L', 250000),
('P02', 'Quần Jean xanh', 'M', 450000),
('P03', 'Áo thun Basic', 'XL', 150000),
('P04', 'Áo hoodie', NULL, -200000);

-- giảm giá P02 còn 400000
UPDATE Products 
SET Price = 400000
WHERE ProductId = 'P02';

-- FIX LỖI 
SET SQL_SAFE_UPDATES = 0;
-- khôi phục lại giá gốc bằng cách tăng 10% toàn bộ sản phẩm.

UPDATE Products 
SET Price = Price * 1.1;

 -- Xóa sản phẩm P03.
 DELETE FROM Products 
 WHERE ProductId = 'P03';

-- Phần 5
-- Xem toàn bộ sản phẩm
SELECT * FROM Products;
-- In nhãn sản phẩm (chỉ cần: Tên, Size).
SELECT ProductName, Size FROM Products;
-- Tìm sản phẩm giá > 300000.
SELECT * FROM Products WHERE Price > 300000;

-- Mở rộng chuyển giá đang âm thành dương
UPDATE PRODUCTS 
SET Price = Price * -1 
WHERE Price < 0;