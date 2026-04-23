USE my2;

-- 1. Tạo bảng sản phẩm
CREATE TABLE PRODUCTS (
	ProductID INT PRIMARY KEY,
	ProductName VARCHAR(100),
	Category VARCHAR(50),
	OriginalPrice DECIMAL(18, 2)
);

-- 2. Chèn dữ liệu mâu (Gồm cả Điện tử và Thực phẩm)
INSERT INTO PRODUCTS (ProductID, ProductName, Category, OriginalPrice)
VALUES
(1, 'iPhone 15', 'Electronics', 20000000),
(2, 'Samsung Refrigerator', 'Electronics', 15000000),
(3, 'Water Spinach', 'Food', 10000),
(4, 'Filtered Fresh Milk 4', 'Food', 28000);

-- 3. ĐOẠN CODE GÂY HÔNG DƯ LIỆU (lôi của thực tập sinh)
-- Hãy phần tích xem tại sao Tên này lại làm "bay màu lợi nhuận của siêu thị?"

-- UPDATE PRODUCTS
-- SET OriginalPrice = OriginalPrice * 0.9;

-- (Gợi ý: Anh ấy đã quên mất điều gì ở cuối câu lệnh?
-- Giải 
-- Lý do vì giảm giá mà ko có lệnh "WHERE" để rằng buộc nên làm cho giảm giá cho tất cả sản phẩm trong đó có cả thực phẩm trong khi đó chỉ 
-- cần giảm giá điện tử nên bị mất việc 

-- Code sửa lại : 
UPDATE PRODUCTS
SET OriginalPrice = OriginalPrice * 0.9 WHERE Category = 'Electronics';