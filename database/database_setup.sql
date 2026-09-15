-- MoMo SMS Data Processing System
-- Database Setup Script

DROP TABLE IF EXISTS sms_message;
DROP TABLE IF EXISTS system_logs;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS transaction_type;
DROP TABLE IF EXISTS users;


CREATE TABLE Transaction_type (
    type_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each transaction type',
    type_name VARCHAR(20) NOT NULL COMMENT 'Short name of the transaction type (e.g. Send Money, Cash Out)',
    description VARCHAR(50) COMMENT 'Brief explanation of what this transaction type represents'
);

CREATE TABLE USERS (
    user_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each user',
    full_name VARCHAR(30) NOT NULL COMMENT 'Full name of the user', 
    phone_number VARCHAR(20) UNIQUE COMMENT 'User''s unique phone number, used to identify their MoMo account', 
    momo_code VARCHAR(20) COMMENT 'MoMo merchant/agent code associated with the user, if applicable'
);

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each transaction',
    financial_txId VARCHAR(20) NOT NULL UNIQUE COMMENT 'Unique transaction reference issued by the MoMo/telecom provider',
    transaction_type_Id INT NOT NULL COMMENT 'References the type of transaction (e.g. Send Money, Airtime Purchase)',
    sender_id INT NOT NULL COMMENT 'References the user who initiated/sent the transaction',
    receiver_id INT NOT NULL COMMENT 'References the user who received the funds or service',
    Amount DECIMAL(10,2) NOT NULL CHECK (Amount > 0) COMMENT 'Transaction amount in RWF; must be positive',
    balance_after DECIMAL(10,2) COMMENT 'Account balance immediately after the transaction completed',
    transaction_fee DECIMAL(10,2) DEFAULT 0.00 COMMENT 'Transaction fee charged for a transaction',
    transaction_time DATETIME NOT NULL COMMENT 'Date and time the transaction occurred',
    transaction_status VARCHAR(20) NOT NULL COMMENT 'Current status of the transaction (e.g. Completed, Pending, Failed)',
    FOREIGN KEY (transaction_type_Id) REFERENCES Transaction_type(type_id),
    FOREIGN KEY (sender_id) REFERENCES USERS(user_id),
    FOREIGN KEY (receiver_id) REFERENCES USERS(user_id)
);

CREATE TABLE SMS_Message (
    sms_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each SMS record',
    transaction_id INT NOT NULL UNIQUE COMMENT 'Links this SMS notification to its corresponding transaction',
    date_sent DATETIME COMMENT 'Date and time the SMS notification was sent',
    address VARCHAR(20) COMMENT 'Sender address or short code of the SMS (e.g. M-Money)',
    raw_body TEXT COMMENT 'Full raw text content of the SMS message',
    read_status VARCHAR(10) COMMENT 'Whether the SMS has been read (Read/Unread)',
    service_center VARCHAR(20) COMMENT 'Phone number of the SMS service center that relayed the message',
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
);

CREATE TABLE System_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for each system log entry',
    transaction_id INT NOT NULL COMMENT 'Links this log entry to its corresponding transaction',
    log_time DATETIME COMMENT 'Date and time the system recorded this transaction event',
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
);


CREATE INDEX idx_phone_number ON users(phone_number);
CREATE INDEX idx_transaction_time ON transactions(transaction_time);
CREATE INDEX idx_sender_id ON transactions(sender_id);
CREATE INDEX idx_receiver_id ON transactions(receiver_id);


INSERT INTO transaction_type (type_name, description) VALUES
('Send Money', 'Transfer of funds from one user to another'),
('Receive Money', 'Funds received from another user'),
('Airtime Purchase', 'Purchase of mobile airtime'),
('Bill Payment', 'Payment of a utility or service bill'),
('Cash Out', 'Withdrawal of funds to cash');

INSERT INTO users (full_name, phone_number, momo_code) VALUES
('Abebe Chala CHEBUDIE', '250795963036', '36521838'),
('Jane Smith', '250790777777', '12845'),
('Samuel Carter', '', '14965'),
('Alex Doe', '250791666666', '23199'),
('John', '250788999999'),
('Sophia', '250790777777')

INSERT INTO transactions (financial_txId, transaction_type_Id, sender_id, receiver_id, Amount, balance_after, transation_fee, transaction_time, transaction_status) VALUES
('73214484437', 1, 1, 2, 1000.00, 1000.00, 0.00, '2024-05-10 16:31:39', '-1'),
('17818959211', 1, 1, 3, 2000.00, 38400.00, 0.00, '2024-05-11 18:48:42', '-1'),
('18249226395', 1, 1, 3, 2000.00, 460.00, 0.00, '2024-05-14 21:29:35', '-1'),
('17007580507', 5, 1, 5, 24000.00, 61892.00, 600.00, '2024-11-23 14:09:27', '-1'),
('14098463509', 5, 1, 6, 20000.00, 6400.00, 350.00,  '2024-05-26 02:10:27', '-1');

INSERT INTO sms_message (transaction_id, date_sent, address, raw_body, read_status, service_center) VALUES
(1, '2024-05-10 16:31:39', 'M-Money', 'TxId: 73214484437. Your payment of 1,000 RWF to Jane Smith 12845 has been completed at 2024-05-10 16:31:39. Your new balance: 1,000 RWF. Fee was 0 RWF.Kanda*182*16# wiyandikishe muri poromosiyo ya BivaMoMotima, ugire amahirwe yo gutsindira ibihembo bishimishije.', '1', '+250788110381'),
(2, '2026-09-10 09:15:07', 'M-Money', 'TxId: 17818959211. Your payment of 2,000 RWF to Samuel Carter 14965 has been completed at 2024-05-11 18:48:42. Your new balance: 38,400 RWF. Fee was 0 RWF.Kanda*182*16# wiyandikishe muri poromosiyo ya BivaMoMotima, ugire amahirwe yo gutsindira ibihembo bishimishije.', '1', '+250788110381'),
(3, '2024-05-14 21:29:35', 'M-Money', 'TxId: 18249226395. Your payment of 2,000 RWF to Alex Doe 23199 has been completed at 2024-05-14 21:29:35. Your new balance: 460 RWF. Fee was 0 RWF.Kanda*182*16# wiyandikishe muri poromosiyo ya BivaMoMotima, ugire amahirwe yo gutsindira ibihembo bishimishije.', '1', '+250788110381'),
(4, '2024-11-23 14:09:27', 'M-Money', 'You Abebe Chala CHEBUDIE (*********036) have via agent: Agent John (250788999999), withdrawn 24000 RWF from your mobile money account: 36521838 at 2024-11-23 14:09:27 and you can now collect your money in cash. Your new balance: 61892 RWF. Fee paid: 600 RWF. Message from agent: 1. Financial Transaction Id: 17007580507.', '1', '+250788110381'),
(5, '2024-05-26 02:10:27', 'M-Money', 'You Abebe Chala CHEBUDIE (*********036) have via agent: Agent Sophia (250790777777), withdrawn 20000 RWF from your mobile money account: 36521838 at 2024-05-26 02:10:27 and you can now collect your money in cash. Your new balance: 6400 RWF. Fee paid: 350 RWF. Message from agent: 1. Financial Transaction Id: 14098463509.', '1', '+250788110381');

INSERT INTO system_logs (transaction_id, log_time) VALUES
(1, '2024-05-10 16:31:39'),
(2, '2026-09-10 09:15:07'),
(3, '2024-05-14 21:29:35'),
(4, '2024-11-23 14:09:27'),
(5, '2024-05-26 02:10:27');


-- =====================================================
-- Sample Queries for Documentation
-- =====================================================

-- 1. All transactions for a specific user (as sender or receiver)
SELECT t.transaction_id, t.financial_txId, u1.full_name AS sender, u2.full_name AS receiver, t.Amount, t.transaction_status
FROM transactions t
JOIN users u1 ON t.sender_id = u1.user_id
JOIN users u2 ON t.receiver_id = u2.user_id
WHERE u1.user_id = 1 OR u2.user_id = 1;

-- 2. Total amount sent by each user
SELECT u.full_name, SUM(t.Amount) AS total_sent
FROM users u
JOIN transactions t ON u.user_id = t.sender_id
GROUP BY u.full_name;

-- 3. Transactions with their type name
SELECT t.transaction_id, tt.type_name, t.Amount, t.transaction_status
FROM transactions t
JOIN transaction_type tt ON t.transaction_type_Id = tt.type_id;

-- 4. All pending transactions
SELECT * FROM transactions WHERE transaction_status = 'Pending';
