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