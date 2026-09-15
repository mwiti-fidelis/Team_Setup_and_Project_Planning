# MoMo SMS Data Processing & Analytics System

## Project Description

This project is a full-stack application for processing and analyzing **Mobile Money (MoMo) SMS data in XML format**.

The system will:

- Parse MoMo SMS data from XML.
- Clean and normalize transaction data.
- Categorize transactions.
- Store the data in a relational database.
- Provide a frontend dashboard for analysis and visualization.

## Team Members

- **[Fidelis Mwiti](https://github.com/mwiti-fidelis)**
- **[Ephraim Mulilo](https://github.com/ephraimm-zm)**
- **[Therese](https://github.com/nshimyumurwa)**

## System Architecture

The high-level system architecture has been designed using Lucidchart.

**Architecture Diagram:**  
[View Architecture Diagram](https://lucid.app/lucidchart/f3f6d837-f0e9-4b5c-82b6-fe84a5c69c8b/edit?invitationId=inv_98b05898-4c4a-4d73-89ef-c3f6efa1b5e7&page=0_0#)

**ERD and Database Design:**  
[View ERD and Database Design](ERD_and_Database_Design_Document)

**Scrum Board:**  
[View Scrum Board](https://github.com/users/mwiti-fidelis/projects/3/views/1)

## JSON and SQL Mapping

The JSON examples represent the data stored in the relational database. Each JSON entity corresponds to one of the main SQL tables, with the JSON fields mapped to their respective SQL columns.

### Entity and Field Mapping

| SQL Table | SQL Column | JSON Field |
|---|---|---|
| `USERS` | `user_id` | `user.user_id` |
| `USERS` | `full_name` | `user.full_name` |
| `USERS` | `phone_number` | `user.phone_number` |
| `USERS` | `momo_code` | `user.momo_code` |
| `Transaction_type` | `type_id` | `transaction_type.type_id` |
| `Transaction_type` | `type_name` | `transaction_type.type_name` |
| `Transaction_type` | `description` | `transaction_type.description` |
| `Transactions` | `transaction_id` | `transaction.transaction_id` |
| `Transactions` | `financial_txId` | `transaction.financial_txId` |
| `Transactions` | `transaction_type_Id` | `transaction.transaction_type_id` |
| `Transactions` | `sender_id` | `transaction.sender_id` |
| `Transactions` | `receiver_id` | `transaction.receiver_id` |
| `Transactions` | `Amount` | `transaction.amount` |
| `Transactions` | `balance_after` | `transaction.balance_after` |
| `Transactions` | `transaction_time` | `transaction.transaction_time` |
| `Transactions` | `transaction_status` | `transaction.transaction_status` |
| `SMS_Message` | `sms_id` | `sms_message.sms_id` |
| `SMS_Message` | `transaction_id` | `sms_message.transaction_id` |
| `SMS_Message` | `date_sent` | `sms_message.date_sent` |
| `SMS_Message` | `address` | `sms_message.address` |
| `SMS_Message` | `raw_body` | `sms_message.raw_body` |
| `SMS_Message` | `read_status` | `sms_message.read_status` |
| `SMS_Message` | `service_center` | `sms_message.service_center` |
| `System_logs` | `log_id` | `system_log.log_id` |
| `System_logs` | `transaction_id` | `system_log.transaction_id` |
| `System_logs` | `log_time` | `system_log.log_time` |

### Relationship Mapping

The JSON structure represents the foreign-key relationships defined in the SQL database.

| SQL Relationship | JSON Representation |
|---|---|
| `Transactions.sender_id → USERS.user_id` | `transaction.sender_id` |
| `Transactions.receiver_id → USERS.user_id` | `transaction.receiver_id` |
| `Transactions.transaction_type_Id → Transaction_type.type_id` | `transaction.transaction_type_id` |
| `SMS_Message.transaction_id → Transactions.transaction_id` | `sms_message.transaction_id` |
| `System_logs.transaction_id → Transactions.transaction_id` | `system_log.transaction_id` |

These relationships allow the JSON records to be linked using the same identifiers and foreign-key relationships used by the relational database.

### SQL to JSON Serialization

The relational database stores the information across separate tables. During serialization, each SQL record is represented as a JSON object, with SQL columns mapped to corresponding JSON fields.

For example:

```text
USERS
    ↓
user

Transaction_type
    ↓
transaction_type

Transactions
    ↓
transaction

SMS_Message
    ↓
sms_message

System_logs
    ↓
system_logs