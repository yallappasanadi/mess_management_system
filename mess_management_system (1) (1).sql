-- Mess Management System SQL (College project  )


CREATE DATABASE IF NOT EXISTS mess_management;
USE mess_management;

-- Admins
CREATE TABLE admins (
  admin_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(150),
  password VARCHAR(200),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Students
CREATE TABLE students (
  student_id INT AUTO_INCREMENT PRIMARY KEY,
  roll_no VARCHAR(20) NOT NULL,
  name VARCHAR(120),
  course VARCHAR(60),
  room_no VARCHAR(20),
  phone VARCHAR(20),
  email VARCHAR(150),
  joined DATE DEFAULT NULL
);

-- Meals 
CREATE TABLE meals (
  meal_id INT AUTO_INCREMENT PRIMARY KEY,
  meal_name VARCHAR(50),
  default_cost DECIMAL(8,2)
);

-- Attendance
CREATE TABLE attendance (
  attendance_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT,
  meal_id INT,
  meal_date DATE,
  recorded_by INT,
  remarks VARCHAR(200),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (meal_id) REFERENCES meals(meal_id),
  FOREIGN KEY (recorded_by) REFERENCES admins(admin_id)
);

-- Payments
CREATE TABLE payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT,
  amount DECIMAL(10,2),
  payment_date DATE,
  payment_mode VARCHAR(50),
  reference_no VARCHAR(100),
  FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Sample data: admins
INSERT INTO admins (name, email, password) VALUES
('Main Admin', 'admin@college.edu', 'admin@123'),
('Mess Incharge', 'mess.incharge@college.edu', 'mess2025');

-- Sample meals
INSERT INTO meals (meal_name, default_cost) VALUES
('Breakfast', 30.00),
('Lunch', 65.00),
('Dinner', 65.00),
('Snacks', 20.00);

-- Sample students
INSERT INTO students (roll_no, name, course, room_no, phone, email, joined) VALUES
('CS2025-01','Yallappa M Sanadi','B.E. CSE','A101','7022511976','yallappa.s@example.com','2024-08-10'),
('CS2025-02','Priya K','B.E. ECE','A102','9000012345','priya.k@example.com','2024-08-12'),
('CS2025-03','Rahul S','B.E. MECH','B201','8888877777','rahul.s@example.com','2024-09-01'),
('CS2025-04','Asha R','B.E. CIVIL','B202','7777766666','asha.r@example.com','2024-09-05'),
('CS2025-05','Deepak T','B.E. CSE','A103','9999988888','deepak.t@example.com','2024-08-20'),
('CS2025-06','Neha D','B.E. ISE','A104','9500001111','neha.d@example.com','2024-08-22');

-- Attendance 
INSERT INTO attendance (student_id, meal_id, meal_date, recorded_by, remarks) VALUES
(1, 2, '2025-11-01', 2, 'Present for lunch'),
(1, 3, '2025-11-01', 2, NULL),
(1, 2, '2025-11-02', 2, 'Late arrival'),
(2, 2, '2025-11-01', 1, NULL),
(2, 1, '2025-11-02', 1, NULL),
(3, 2, '2025-11-01', 2, NULL),
(3, 3, '2025-11-01', 2, NULL),
(4, 2, '2025-11-03', 1, 'Guest meal'),
(5, 1, '2025-11-01', 2, NULL),
(5, 2, '2025-11-02', 2, NULL),
(6, 2, '2025-11-01', 1, NULL),
(6, 3, '2025-11-01', 1, NULL),
(2, 3, '2025-11-04', 1, 'Extra dinner'),
(1, 1, '2025-11-05', 2, 'Breakfast before exam');


INSERT INTO attendance (student_id, meal_id, meal_date, recorded_by) VALUES
(1,2,'2025-11-10',2),
(2,2,'2025-11-10',1),
(3,2,'2025-11-10',1),
(4,3,'2025-11-11',2),
(5,2,'2025-11-11',2),
(6,1,'2025-11-12',1);

-- Payments sample
INSERT INTO payments (student_id, amount, payment_date, payment_mode, reference_no) VALUES
(1, 1500.00, '2025-11-02', 'UPI', 'UPI-111-2025'),
(2, 1200.00, '2025-11-03', 'Cash', 'CASH-23'),
(3, 1600.00, '2025-11-05', 'NEFT', 'NEFT-9988'),
(5, 1400.00, '2025-11-06', 'UPI', 'UPI-555');



-- 1) Total meals taken by each student
SELECT s.roll_no, s.name, COUNT(a.attendance_id) AS meals_nov
FROM students s
LEFT JOIN attendance a ON s.student_id = a.student_id
  AND a.meal_date BETWEEN '2025-11-01' AND '2025-11-30'
GROUP BY s.student_id, s.roll_no, s.name
ORDER BY meals_nov DESC;

-- 2) Meal-wise count for November
SELECT m.meal_name, COUNT(a.attendance_id) AS cnt
FROM meals m
LEFT JOIN attendance a ON m.meal_id = a.meal_id
  AND a.meal_date BETWEEN '2025-11-01' AND '2025-11-30'
GROUP BY m.meal_name;

-- 3) Simple billing: sum default costs 
SELECT s.roll_no, s.name, COALESCE(SUM(m.default_cost),0) AS total_bill
FROM students s
LEFT JOIN attendance a ON s.student_id = a.student_id
LEFT JOIN meals m ON a.meal_id = m.meal_id
WHERE a.meal_date BETWEEN '2025-11-01' AND '2025-11-30'
GROUP BY s.student_id, s.roll_no, s.name
ORDER BY total_bill DESC;

-- 4) Payments vs bill 
SELECT p.student_id, s.name,
  COALESCE(SUM(p.amount),0) AS paid,
  COALESCE(b.total_bill,0) AS bill,
  (COALESCE(b.total_bill,0) - COALESCE(SUM(p.amount),0)) AS balance
FROM payments p
JOIN students s ON p.student_id = s.student_id
LEFT JOIN (
   SELECT s2.student_id, SUM(m.default_cost) AS total_bill
   FROM students s2
   JOIN attendance a2 ON s2.student_id = a2.student_id
   JOIN meals m ON a2.meal_id = m.meal_id
   WHERE a2.meal_date BETWEEN '2025-11-01' AND '2025-11-30'
   GROUP BY s2.student_id
) b ON p.student_id = b.student_id
GROUP BY p.student_id, s.name;

