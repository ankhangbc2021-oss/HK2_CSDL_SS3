USE my2;

CREATE TABLE CART_ITEMS (
	CartItemID INT PRIMARY KEY AUTO_INCREMENT,
	UserID INT,
	ProductID INT,
	Quantity INT CHECK(Quantity > 0),
	AddedDate DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Giải các yêu cầu 

-- 1 Thiết kế luồng xử lý "Bẫy dữ liệu" (Edge Cases): Hệ thống của bạn sẽ dùng lệnh DML nào và xử lý ra sao nếu:
-- Khách hàng cố tình nhập số lượng (Quantity) là một số âm (ví dụ: -5)?

-- Nếu khách hàng nhập như vậy ta cần phải có 1 hệ thống chặn vd như CHECK (VD: CHECK Quantity > 0 hoặc CHECK Quantity >= 0 khi tạo bảng )

-- Khách hàng bấm "Add to cart" đúng mặt hàng đã có sẵn trong giỏ? (Gợi ý: Update số lượng hay Insert dòng mới?).

-- Nếu sản phẩm đã có trong giỏ, thay vì INSERT dòng mới, ta nên UPDATE số lượng để cộng thêm.
-- Điều này giúp giỏ hàng gọn gàng, tránh trùng lặp.

-- 2 Sản phẩm hoàn chỉnh (Source Code DML): Viết 4 câu lệnh SQL (INSERT, SELECT, UPDATE, DELETE) phục vụ cho 4 
-- tính năng trên. Đảm bảo các câu lệnh cập nhật hoặc xóa phải có chốt chặn WHERE để người này không can thiệp vào giỏ 
-- hàng của người khác.

-- Nếu sản phẩm chưa có, thêm mới
INSERT INTO CART_ITEMS (UserID, ProductID, Quantity)
VALUES (123, 456, 1)
ON DUPLICATE KEY UPDATE Quantity = Quantity + VALUES(Quantity);

SELECT ProductID, Quantity, AddedDate
FROM CART_ITEMS
WHERE UserID = 123;

UPDATE CART_ITEMS
SET Quantity = 5
WHERE UserID = 123 AND ProductID = 456;

DELETE FROM CART_ITEMS
WHERE UserID = 123 AND ProductID = 456;

