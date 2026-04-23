USE my2;

-- 1. Tạo bằng khách hàng với hàng chục cột (mô phỏng bảng lớn)
CREATE TABLE CUSTOMERS (
CustomerID INT PRIMARY KEY AUTO_INCREMENT,
FullName VARCHAR( 100),
Email VARCHAR(100),
City VARCHAR(50),
LastPurchaseDate DATE, -- Ngày mua hàng cuối cùng
-- Trạng thát tài khoản (Active, Locked ... )

Status VARCHAR(20),
Gender VARCHAR(10),
DateOfBirth DATE,
Points INT,
Address VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Dữ liệu mau với cac "Bay du lieu"
-- - Luu ý: Trong MySQL khong can tien to N' truoc cac chuoi tieng Viet

INSERT INTO CUSTOMERS (FullName, Email, City, LastPurchaseDate, Status) VALUES
('Nguyen Văn A', 'anv@gmail.com', 'Hà Nội', '2025-05-20', 'Active' ), -- Khach tiem nang (hon 6 tháng)
('Trần Thị B', 'btt@gmail.com', 'Hà Nội', '2026-02-10', 'Active' ), -- Mới mua (Loạt)
('Lê Văn C', NULL, 'Hà Nội', '2025-01-15', 'Active' ), -- Loi: Không co Email
('Phạm Minh D', 'dpm@gmail.com', 'Hà Nội', '2024-12-01', 'Locked' ), -- Loi: Tai khoan bi kho
('Hoang An E', 'eha@gmail.com', 'TP HCM', '2025-03-01', 'Active' );  -- Loi: Sai thanh pho


-- Giải 

-- 1 Phân tích bài toán (I/O): Xác định input cần quét ở bảng nào, output cần trả ra những cột nào?. Tại sao việc sử dụng lệnh SELECT * trong trường hợp này lại là một sai lầm làm nghẽn cổ chai hệ thống?.

-- input thì cần nhập hết bao gồm (FullName, Email, City, LastPurchaseDate, Status) nhưng output thì chỉ cần FullName và Email thôi
-- nên việc dùng SELECT* hệ thống sẽ tải toàn bộ dữ liệu và làm chậm . Đây là sai lầm nghiêm trọng 

-- 2 Thiết kế giải pháp: Trình bày logic lọc dữ liệu (các điều kiện cần có trong mệnh đề WHERE).

-- Sử dụng WHERE Ví dụ: nếu tìm city ở Hà Nội thì sài City = 'Hà Nội' hoặc tìm trạng thái thì Status = 'Active'

-- 3 Triển khai code: Viết câu lệnh SELECT đáp ứng chuẩn xác nhu cầu của Sếp, bao gồm cả điều kiện lọc loại bỏ các "Bẫy dữ liệu" (Không có email hoặc tài khoản bị khóa).

SELECT FullName, Email FROM CUSTOMERS
WHERE City = 'Hà Nội'
  AND LastPurchaseDate <= '2025-10-01'
  AND Email IS NOT NULL
  AND Status = 'Active';
