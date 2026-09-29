import json
import time

def load_data(filepath: str) -> list[dict]:
    with open(filepath, 'r', encoding='utf-8') as file:
        return json.load(file) 

def linear_search(transactions: list[dict], target_ID: str) -> dict | None:
    for transaction in transactions: 
        if transaction.get('ID') == str(target_ID):
            return transaction
    return None

def create_dictionary(transactions: list[dict]) -> dict[str, dict]:
    # Build a dictionary by mapping ID string 
    return {transaction['ID']: transaction for transaction in transactions}

def hashmap_data_search(transaction_dictionary: dict[str, dict], target_ID: str) -> dict | None:
    return transaction_dictionary.get(str(target_ID))

