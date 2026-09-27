from http.server import BaseHTTPRequestHandler, HTTPServer
import json

def load_data():
    with open('data.json', 'r') as file:
        data = json.load(file)
    return data

def save_data(data):
    with open('data.json', 'w') as file:
        json.dump(data, file, indent=4)

class RequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        print("Get request received")
        if not self.path.startswith('/transactions'):
            self.send_response(404)
            self.end_headers()
            return    
        data = load_data()
    
        if self.path == '/transactions':
            response = json.dumps(data).encode()
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            self.wfile.write(response)
            return
        
        parts = self.path.split('/')
        
        if len(parts) >= 3:
            transaction_id = parts[2]
            found = False
            for transaction in data:
                if transaction["ID"] == transaction_id:
                    found = True
                    response = json.dumps(transaction).encode()
                    self.send_response(200)
                    self.send_header('Content-Type', 'application/json')
                    self.end_headers()
                    self.wfile.write(response)
                    break
            if not found:
                self.send_response(404)
                self.end_headers()
    def do_POST(self):
        print("Post request received")
        content_length = int(self.headers['Content-Length'])
        body = self.rfile.read(content_length)
        data = json.loads(body)
        transactions = load_data()
        transactions.append(data)
        print("Updated transactions:", transactions)
        save_data(transactions)
        self.send_response(201)
        self.send_header('Content-Type', 'application/json')
        self.end_headers()

        response = json.dumps(data).encode()
        self.wfile.write(response)

    def do_PUT(self):
        print("Put request received")
        parts = self.path.split('/')
        transaction_id = parts[2]
        content_length = int(self.headers['Content-Length'])
        body = self.rfile.read(content_length)
        updated_data = json.loads(body)
        transactions = load_data()
        found = False
        for i, transaction in enumerate(transactions):
            if transaction["ID"] == transaction_id:
                transactions[i] = updated_data
                found = True
        if found:
            save_data(transactions)
            self.send_response(200)
            self.end_headers()

            response = json.dumps(updated_data).encode()
            self.wfile.write(response)
        else:
            self.send_response(404)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            response = json.dumps({"message": "Transaction not found"}).encode()
            self.wfile.write(response)

    def do_DELETE(self):
            
        print("Delete request received")
        parts = self.path.split('/')
        transaction_id = parts[2]
        transactions = load_data()
        found = False
        for i, transaction in enumerate(transactions):
            if transaction["ID"] == transaction_id:
                del transactions[i]
                found = True
                break
        if found:
            save_data(transactions)
            self.send_response(200)
            self.end_headers()
        else:
            self.send_response(404)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            response = json.dumps({"message": "Transaction not found"}).encode()
            self.wfile.write(response)

server = HTTPServer(('localhost', 8080), RequestHandler)
print("Server started on http://localhost:8080")
server.serve_forever() 