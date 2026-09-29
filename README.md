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
[View ERD and Database Design](https://docs.google.com/document/d/13JHUDYC6kKOt0D5DObEcpIL_LN5z0mpmzeDvZD5hEyc/edit?tab=t.0)

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

### AI Usage Policy Compliance
#By Therese
    AI was used to:
    -Troubleshoot MySQL/PowerShell installation and setup issue
    -Generate fictional placeholder data for testing (to be replaced with real parsed data)
    -Help draft sample SQL queries for documentation

#Ephraim Mulilo
     AI was used in this part as follows:
    - Understand the assignment requirements.
    - Review JSON syntax work for basic errors.
    - Review the README to make sure the JSON documentation is clear.
    - Improve the grammar and formatting of the README."

#By Fidelis Mwiti
    AI usage included:
        -Query AI to know the meaning of abbreviations used in the raw momo.xml such as "toa", "sc_toa", e.t.c.
        -Queried how it is possible that some transactions do not have any transaction id.
        -Used grammarly for grammar correction and formating of the ERD design documentation.

# Assignment: Building and Securing a REST API

## Overview

As part of the MoMo SMS Data Processing & Analytics System, a REST-style API was developed to provide access to and manage processed MoMo transaction data.

The assignment covers:

- Transaction CRUD operations.
- API authentication and security.
- API documentation.
- Data Structures & Algorithms integration.
- API testing and validation.

---

## 1. Transaction CRUD API

A REST-style CRUD API was implemented using Python's built-in `http.server` module and a JSON file for data storage.

### Requirements

- Python 3.x
- curl or Postman

### Setup

From the project root directory, start the API server:

```bash
python api/server.py
```

The API runs at:

```text
http://localhost:8080
```

### API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/transactions` | Get all transactions |
| `GET` | `/transactions/{id}` | Get one transaction |
| `POST` | `/transactions` | Create a transaction |
| `PUT` | `/transactions/{id}` | Update a transaction |
| `DELETE` | `/transactions/{id}` | Delete a transaction |

### Get All Transactions

**Request:**

```bash
curl http://localhost:8080/transactions
```

**Endpoint:**

```text
GET /transactions
```

**Description:**

Returns all transaction records stored by the API.

### Get One Transaction

**Request:**

```bash
curl http://localhost:8080/transactions/2000
```

**Endpoint:**

```text
GET /transactions/{id}
```

**Description:**

Returns a single transaction matching the provided transaction ID.

### Create a Transaction

**Request:**

```bash
curl -X POST http://localhost:8080/transactions \
-H "Content-Type: application/json" \
-d '{"ID":"3000","TransactionType":"MoMo Send Money","Amount":"500 RWF","Sender":"John","Receiver":"Mary","DateTime":"2024-11-20 12:00:00","rawBody":"test transaction"}'
```

**Endpoint:**

```text
POST /transactions
```

**Description:**

Creates a new transaction using the JSON data provided in the request body.

**Expected response:**

```text
201 Created
```

### Update a Transaction

**Request:**

```bash
curl -X PUT http://localhost:8080/transactions/2000 \
-H "Content-Type: application/json" \
-d '{"ID":"2000","TransactionType":"MoMo Send Money","Amount":"8888 RWF","Sender":"John","Receiver":"Mary","DateTime":"2024-11-20 12:00:00","rawBody":"updated transaction"}'
```

**Endpoint:**

```text
PUT /transactions/{id}
```

**Description:**

Updates an existing transaction using the provided transaction ID.

**Expected response:**

```text
200 OK
```

### Delete a Transaction

**Request:**

```bash
curl -X DELETE http://localhost:8080/transactions/2000
```

**Endpoint:**

```text
DELETE /transactions/{id}
```

**Description:**

Deletes an existing transaction using the provided transaction ID.

**Expected response:**

```text
200 OK
```

### Response Codes

| Code | Meaning |
|------|---------|
| `200` | Request successful |
| `201` | Transaction created |
| `401` | Unauthorized |
| `404` | Transaction not found |

---

## 2. Authentication & Security

The API endpoints are protected using **Basic Authentication**.

Clients must provide valid credentials when making requests to protected endpoints.

### Authenticated Request

Example:

```bash
curl -u username:password http://localhost:8080/transactions
```

The `-u` option provides the username and password for Basic Authentication.

### Invalid Credentials

If incorrect credentials are provided, the API returns:

```text
401 Unauthorized
```

Example:

```bash
curl -u wrong:password http://localhost:8080/transactions
```

Expected response:

```text
401 Unauthorized
```

### Why Basic Authentication Is Weak

Basic Authentication is simple to implement but has security limitations.

The username and password are encoded using Base64 rather than encrypted. Base64 encoding does not provide confidentiality, meaning the credentials can potentially be exposed if the connection is not properly secured.

For this reason, Basic Authentication should be used together with **HTTPS** in a production environment.

### Stronger Alternatives

Two stronger authentication approaches that could be used are:

#### JWT

**JSON Web Tokens (JWT)** can be used for token-based authentication. After successfully authenticating, a client receives a token that can be included in subsequent API requests.

#### OAuth 2.0

**OAuth 2.0** provides a standardized authorization framework that allows applications to securely access resources without requiring users to directly share their credentials with every service.

---

## 3. API Documentation

The API documentation provides information about each endpoint, including:

- HTTP method.
- Endpoint.
- Request format.
- Request example.
- Response format.
- Response example.
- Error codes.

Detailed API documentation is available in:

```text
docs/api_docs.md
```

### API Error Codes

| HTTP Code | Meaning |
|-----------|---------|
| `200` | Request successful |
| `201` | Transaction created successfully |
| `401` | Unauthorized - invalid or missing credentials |
| `404` | Transaction not found |

---

## 4. Data Structures & Algorithms (DSA) Integration

Two different approaches were implemented and compared for searching transactions by ID:

1. Linear Search
2. Dictionary Lookup

The approaches were tested using at least **20 transaction records** to compare their efficiency.

### Linear Search

Linear search scans through the transaction list one record at a time until the requested transaction ID is found.

Conceptually:

```text
Transaction 1
     ↓
Transaction 2
     ↓
Transaction 3
     ↓
     ...
     ↓
Target Transaction
```

The time complexity of linear search is:

```text
O(n)
```

This means that as the number of transactions increases, the number of records that may need to be checked also increases.

For example, if there are 20 records, a linear search may need to check up to 20 records in the worst case.

### Dictionary Lookup

A dictionary can store transactions using the transaction ID as the key.

Example:

```python
transactions = {
    "2000": transaction,
    "2001": transaction,
    "2002": transaction
}
```

The transaction can then be accessed directly using its ID:

```python
transactions["2000"]
```

The average time complexity of dictionary lookup is:

```text
O(1)
```

This means that the lookup generally takes approximately the same amount of time regardless of how many records are stored.

### Efficiency Comparison

| Search Method | Data Structure | Average Time Complexity |
|---------------|----------------|-------------------------|
| Linear Search | List | `O(n)` |
| Dictionary Lookup | Dictionary | `O(1)` |

Dictionary lookup is generally faster because the transaction ID is used as a key to directly locate the transaction.

Linear search, on the other hand, may have to check multiple records before finding the requested transaction.

### Alternative Data Structures or Algorithms

Another possible approach is **Binary Search**.

Binary search works by repeatedly dividing a sorted list into smaller sections until the target is found.

Its time complexity is:

```text
O(log n)
```

However, binary search requires the transaction records to be sorted by the value being searched.

For transaction IDs, a dictionary is suitable when fast direct lookup is required.

---

## 5. Testing & Validation

The API was tested using **curl/Postman** to verify that the endpoints, authentication, and CRUD operations work correctly.

The following tests were performed.

### Successful GET With Authentication

**Request:**

```bash
curl -u username:password http://localhost:8080/transactions
```

**Expected result:**

```text
200 OK
```

The response should contain the available transaction records.

A screenshot of the successful authenticated GET request is included in:

```text
screenshots/
```

### Unauthorized Request With Wrong Credentials

**Request:**

```bash
curl -u wrong:password http://localhost:8080/transactions
```

**Expected result:**

```text
401 Unauthorized
```

This confirms that the API rejects requests with invalid credentials.

A screenshot of the unauthorized request is included in:

```text
screenshots/
```

### Successful POST

A new transaction was created using:

```text
POST /transactions
```

**Expected result:**

```text
201 Created
```

This confirms that the API can successfully add new transaction records.

### Successful PUT

An existing transaction was updated using:

```text
PUT /transactions/{id}
```

**Expected result:**

```text
200 OK
```

This confirms that existing transaction records can be modified.

### Successful DELETE

An existing transaction was deleted using:

```text
DELETE /transactions/{id}
```

**Expected result:**

```text
200 OK
```

This confirms that transaction records can be removed successfully.

### Testing Screenshots

Screenshots of the API testing results are stored in:

```text
screenshots/
```

The screenshots include:

- Successful authenticated GET request.
- Unauthorized request with incorrect credentials.
- Successful POST request.
- Successful PUT request.
- Successful DELETE request.

---

## 6. Transaction Data Format

Transactions are stored in:

```text
api/data.json
```

Example transaction:

```json
{
  "ID": "2000",
  "TransactionType": "MoMo Send Money",
  "Amount": "500 RWF",
  "Sender": "John",
  "Receiver": "Mary",
  "DateTime": "2024-11-20 12:00:00",
  "rawBody": "test transaction"
}
```

### Transaction Fields

| Field | Description |
|-------|-------------|
| `ID` | Unique transaction identifier |
| `TransactionType` | Type of Mobile Money transaction |
| `Amount` | Transaction amount |
| `Sender` | Person or entity sending the money |
| `Receiver` | Person or entity receiving the money |
| `DateTime` | Date and time of the transaction |
| `rawBody` | Original SMS content |

---

## 7. Project Files Used for the Assignment

The main files related to the REST API assignment are:

```text
api/
├── server.py
└── data.json

docs/
└── api_docs.md

screenshots/
```

### File Descriptions

| File | Purpose |
|------|---------|
| `api/server.py` | Contains the REST API and CRUD operations |
| `api/data.json` | Stores the transaction records |
| `docs/api_docs.md` | Contains detailed API documentation |
| `screenshots/` | Contains API testing screenshots |

---

## 8. Assignment Contributions

| Team Member | Assigned Task |
|-------------|---------------|
| **Nshimyumurwa Mary Therese** | Authentication & Security and API Documentation |
| **Fidelis Mwiti** | Data Structures & Algorithms Integration |
| **Ephraim Mulilo** | SMS Data Parsing and CRUD API Implementation |
| **All Team Members** | Testing & Validation |

---

## 9. Assignment Summary

The assignment extended the MoMo SMS Data Processing & Analytics System with a REST API for managing transaction data.

The API supports the main CRUD operations:

```text
GET
POST
PUT
DELETE
```

Basic Authentication was added to protect the API endpoints, with unauthorized requests returning `401 Unauthorized`.

The project also demonstrates the difference between linear search and dictionary lookup, showing how the choice of data structure can affect search efficiency.

Finally, the API was tested using curl/Postman, with successful and unauthorized requests documented through screenshots.