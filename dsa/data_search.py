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


def search_efficiency_test():
    # Loading the transactions list and coverting the transactions list to a dictionary for use in hashmap search
    transactions_list = load_data('data.json')
    transaction_dictionary = create_dictionary(transactions_list)

    # setting a worst case scenarion target_id for search
    search_choice = input('Would you like to run the worst case scenario search?(yes/no)\n')
    if search_choice.lower() == 'yes':
        target_id = str(len(transactions_list))
            # Linear search time countdown

        start_time = time.perf_counter()
        res_linear = linear_search(transactions_list, target_id)
        linear_time = (time.perf_counter() - start_time) * 1000

        # Hash map search time countdown

        start_time = time.perf_counter()
        res_dictionary = hashmap_data_search(transaction_dictionary, target_id)
        dictionary_search_time = (time.perf_counter() - start_time) * 1000

        print('============ Search Speed efficiency test results  ===============\n')
        print(f'Dataset size: {len(transactions_list)} transactions')
        print(f'\n Target ID: {target_id}')
        print(f'\n Linear search time: {linear_time:.6f} milliseconds')
        print(f'\n Dictionary search time: {dictionary_search_time:.6f} milliseconds')

        if dictionary_search_time > 0:
            print(f'\nDictionary/hashmap search is:   {linear_time/dictionary_search_time:.2f}x faster than linear search\n')
            print('='*65)

    elif search_choice.lower() == 'no': 
        search_target = input('Enter the transaction ID you wish to search(e.g: 10,20,30..):')
        try:
            search_target = int(search_target)
            if search_target < len(transactions_list):
                target_id = str(search_target)

                    # Linear search time countdown

                start_time = time.perf_counter()
                res_linear = linear_search(transactions_list, target_id)
                linear_time = (time.perf_counter() - start_time) * 1000

                # Hash map search time countdown

                start_time = time.perf_counter()
                res_dictionary = hashmap_data_search(transaction_dictionary, target_id)
                dictionary_search_time = (time.perf_counter() - start_time) * 1000

                print('\n============= Search Speed efficiency test results  ===============\n')
                print(f'Dataset size: {len(transactions_list)} transactions')
                print(f'\n Target ID: {target_id}')
                print(f'\n Linear search time: {linear_time:.6f} milliseconds')
                print(f'\n Dictionary search time: {dictionary_search_time:.6f} milliseconds')

                if dictionary_search_time > 0:
                    print(f'\nDictionary/hashmap search is:   {linear_time/dictionary_search_time:.2f}x faster than linear search\n')
                    print('='*65)


        except ValueError as e:
            print('Invalid transaction Id', e)
    else:
        print("Invalid search choice. Please retry and enter either yes/no. Exiting...")


if __name__ == "__main__":
    search_efficiency_test()
