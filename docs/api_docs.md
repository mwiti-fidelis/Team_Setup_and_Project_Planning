# Transaction CRUD API

A simple REST-style CRUD API built with Python's built-in `http.server` module and a JSON file for data storage.

## Requirements

- Python 3.x
- curl

## Setup

1. Clone the repository:

```bash
git clone <repository-url>
cd <project-directory>
```

2. Make sure `data.json` exists in the project directory.

3. Start the server:

```bash
python server.py
```

The API runs at:

```text
http://localhost:8080
```

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/transactions` | Get all transactions |
| GET | `/transactions/{id}` | Get one transaction |
| POST | `/transactions` | Create a transaction |
| PUT | `/transactions/{id}` | Update a transaction |
| DELETE | `/transactions/{id}` | Delete a transaction |

## Examples

### Get all transactions

```bash
curl http://localhost:8080/transactions
```

### Get one transaction

```bash
curl http://localhost:8080/transactions/2000
```

### Create a transaction

```bash
curl -X POST http://localhost:8080/transactions \
-H "Content-Type: application/json" \
-d '{"ID":"3000","TransactionType":"MoMo Send Money","Amount":"500 RWF","Sender":"John","Receiver":"Mary","DateTime":"2024-11-20 12:00:00","rawBody":"test transaction"}'
```

### Update a transaction

```bash
curl -X PUT http://localhost:8080/transactions/2000 \
-H "Content-Type: application/json" \
-d '{"ID":"2000","TransactionType":"MoMo Send Money","Amount":"8888 RWF","Sender":"John","Receiver":"Mary","DateTime":"2024-11-20 12:00:00","rawBody":"updated transaction"}'
```

### Delete a transaction

```bash
curl -X DELETE http://localhost:8080/transactions/2000
```

## Response Codes

| Code | Meaning |
|------|---------|
| `200` | Request successful |
| `201` | Transaction created |
| `404` | Transaction not found |

## Data Format

Transactions are stored in `data.json`:

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