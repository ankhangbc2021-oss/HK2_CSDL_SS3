USE my2;

-- 3. Vẫn đề truy vẫn chậm:
-- Môi khi tìm đơn hàng "Sống", hệ thông van phải quét qua đồng đơn "Hủy"
SELECT * FROM ORDERS WHERE Status = 'Completed';

-- - 1. Cầu trúc bảng đơn hàng hiện tại
CREATE TABLE ORDERS (
OrderID INT PRIMARY KEY AUTO_INCREMENT,
CustomerName VARCHAR(100),
OrderDate DATETIME,
TotalAmount DECIMAL(18, 2),
Status VARCHAR(20), -- 'Completed', 'Canceled', 'Pending'

-- Giải pháp Soft Delete thường yêu cầu thêm cột này:
-- Trong MySQL, TINYINT (1) thường được dùng thay cho BIT

IsDeleted TINYINT(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Dữ liệu thực tề: Hồn hợp đơn hàng thành công và đơn hàng bị hủy
INSERT INTO ORDERS (CustomerName, OrderDate, TotalAmount, Status) VALUES
('Nguyên Văn A', '2023-01-10', 500000, 'Completed' ), 
('Khách hàng vng lai', '2023-02-15', 1200000, 'Canceled' ), -- "Rác" cần xử lý
('Trần Thị B', '2023-05-20', 300000, 'Canceled' ), -- "Rác" cân xử lý
('Lê Văn C', '2024-01-05', 850000, 'Completed' );

-- 3. Vẫn đề truy vần chậm:
-- Mỗi khi tìm đơn hàng "Sống", hệ thong vẫn phải quét qua đồng đơn "Hủy"
SELECT * FROM ORDERS WHERE Status = 'Completed';

-- Truy van cho ung dung ban hang (Khong thay dơn huy)
-- SELECT * FROM ORDERS WHERE IsDeleted = 0;

-- Truy vần cho Kề toán (Van thay đơn hủy đe đồi soat)
-- SELECT * FROM ORDERS WHERE Status = 'Canceled';

-- Giải các yêu cầu 

-- 1 Phân tích & Đề xuất: Đưa ra 2 giải pháp thao tác dữ liệu để xử lý bài toán này:
-- Giải pháp 1 (Hard Delete): Dùng lệnh DELETE FROM có chọn lọc.

DELETE FROM ORDERS
WHERE Status = 'Canceled';
-- Xóa vật lý toàn bộ đơn hàng bị hủy khỏi bảng.

-- Giải pháp 2 (Soft Delete): Không xóa thật, mà dùng lệnh UPDATE để chuyển một cờ (flag) ví dụ: is_deleted = 1.

UPDATE ORDERS 
SET IsDeleted = 1 
WHERE Status = 'Canceled';
-- Không xóa thật, chỉ đánh dấu bằng cờ IsDeleted = 1.
-- Các truy vấn bán hàng sẽ lọc IsDeleted = 0 để bỏ qua đơn hủy.
-- Kế toán vẫn có thể truy vấn lại khi cần đối soát.

-- 2 So sánh & Lựa chọn: Lập bảng so sánh Ưu/Nhược điểm của từng phương pháp (Dựa trên tiêu chí: Giải phóng dung lượng ổ cứng, Tốc độ truy vấn, và Tính vẹn toàn lịch sử kế toán).

-- Tiêu chí						|Hard Delete					|Soft Delete
-- Giải phóng dung lượng ổ cứng | Có, dữ liệu bị xóa hoàn toàn  | Không, dữ liệu vẫn tồn tại
-- Tốc độ truy vấn              |Nhanh hơn vì bảng gọn nhẹ	    |Cần thêm điều kiện IsDeleted = 0 nhưng vẫn ổn
-- Tính vẹn toàn lịch sử kế toán|Mất dữ liệu, không thể đối soát| Giữ nguyên, dễ dàng truy vấn lại

-- 3 Thiết kế & Triển khai: Đóng vai trò là Kỹ sư trưởng, bạn hãy chốt 1 giải pháp phù hợp nhất với bối cảnh siêu thị cần lưu trữ lịch sử kiểm toán. Viết mã SQL thực thi giải pháp đó.

-- đánh dấu hủy đơn 
UPDATE ORDERS
SET IsDeleted = 1
WHERE Status = 'Canceled';

-- Truy vấn cho ứng dụng bán hàng (ẩn đơn hủy)
SELECT *
FROM ORDERS
WHERE IsDeleted = 0;

-- Truy vấn cho kế toán (vẫn thấy đơn hủy)
SELECT * 
FROM ORDERS 
WHERE IsDeleted = 1;
