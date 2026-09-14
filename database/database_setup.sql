-- MoMo SMS Data Processing System
-- Database Setup Script
-- Author: nshimyumurwa
-- Team: Team_Setup_and_Project_Planning
-- Date: 14/09/2026



DROP TABLE IF EXISTS sms_message;
DROP TABLE IF EXISTS system_logs;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS transaction_type;
DROP TABLE IF EXISTS users;


CREATE TABLE Transaction_type (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(20) NOT NULL,
    description VARCHAR(50)
);

CREATE TABLE USERS (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(30) NOT NULL, 
    phone_number VARCHAR(20) NOT NULL UNIQUE, 
    momo_code VARCHAR(20) 
);

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '____',
    financial_txId VARCHAR(20) NOT NULL UNIQUE COMMENT '____',
    transaction_type_Id INT NOT NULL COMMENT '____',
    sender_id INT NOT NULL COMMENT '____',
    receiver_id INT NOT NULL COMMENT '____',
    Amount DECIMAL(10,2) NOT NULL COMMENT '____',
    balance_after DECIMAL(10,2) COMMENT '____',
    transaction_time DATETIME NOT NULL COMMENT '____',
    transaction_status VARCHAR(20) NOT NULL COMMENT '____',
    FOREIGN KEY (transaction_type_Id) REFERENCES Transaction_type(type_id),
    FOREIGN KEY (sender_id) REFERENCES USERS(user_id),
    FOREIGN KEY (receiver_id) REFERENCES USERS(user_id)
);

CREATE TABLE SMS_Message (
    sms_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '____',
    transaction_id INT NOT NULL UNIQUE COMMENT '____',
    date_sent DATETIME COMMENT '____',
    address VARCHAR(20) COMMENT '____',
    raw_body TEXT COMMENT '____',
    read_status VARCHAR(10) COMMENT '____',
    service_center VARCHAR(20) COMMENT '____',
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
);

CREATE TABLE System_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '____',
    transaction_id INT NOT NULL UNIQUE COMMENT '____',
    log_time DATETIME COMMENT '____',
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
);



INSERT INTO transaction_type (type_name, description) VALUES
('Send Money', 'Transfer of funds from one user to another'),
('Receive Money', 'Funds received from another user'),
('Airtime Purchase', 'Purchase of mobile airtime'),
('Bill Payment', 'Payment of a utility or service bill'),
('Cash Out', 'Withdrawal of funds to cash');

INSERT INTO users (full_name, phone_number, momo_code) VALUES
('Jean Uwimana', '250788123456', 'MC1001'),
('Alice Mukamana', '250788234567', 'MC1002'),
('Eric Niyonsenga', '250788345678', 'MC1003'),
('Claudine Ingabire', '250788456789', 'MC1004'),
('Patrick Habimana', '250788567890', 'MC1005');

INSERT INTO transactions (financial_txId, transaction_type_Id, sender_id, receiver_id, Amount, balance_after, transaction_time, transaction_status) VALUES
('TX00001', 1, 1, 2, 15000.00, 85000.00, '2026-09-10 09:15:00', 'Completed'),
('TX00002', 2, 2, 1, 15000.00, 100000.00, '2026-09-10 09:15:05', 'Completed'),
('TX00003', 3, 3, 3, 2000.00, 48000.00, '2026-09-11 14:22:00', 'Completed'),
('TX00004', 4, 4, 4, 12500.00, 37500.00, '2026-09-12 11:05:00', 'Completed'),
('TX00005', 5, 5, 5, 20000.00, 30000.00, '2026-09-13 16:40:00', 'Pending');

INSERT INTO sms_message (transaction_id, date_sent, address, raw_body, read_status, service_center) VALUES
(1, '2026-09-10 09:15:02', 'M-Money', 'You have sent 15000 RWF to Alice Mukamana.', 'Read', '+250788000001'),
(2, '2026-09-10 09:15:07', 'M-Money', 'You have received 15000 RWF from Jean Uwimana.', 'Read', '+250788000001'),
(3, '2026-09-11 14:22:03', 'M-Money', 'You have purchased 2000 RWF airtime.', 'Unread', '+250788000001'),
(4, '2026-09-12 11:05:02', 'M-Money', 'You have paid 12500 RWF for electricity bill.', 'Read', '+250788000001'),
(5, '2026-09-13 16:40:04', 'M-Money', 'Cash out request of 20000 RWF is pending.', 'Unread', '+250788000001');

INSERT INTO system_logs (transaction_id, log_time) VALUES
(1, '2026-09-10 09:15:01'),
(2, '2026-09-10 09:15:06'),
(3, '2026-09-11 14:22:01'),
(4, '2026-09-12 11:05:01'),
(5, '2026-09-13 16:40:01');