#!/usr/bin/python3
"""
This module fetches data from two different APIs
and creates a dictionary of tasks for each user.
The data is then exported to a JSON file.
"""

import json
import requests


def fetch_data():
    # Fetch users data
    users_response = requests.get('https://jsonplaceholder.typicode.com/users')
    users = users_response.json()

    # Fetch todos data
    todos_response = requests.get('https://jsonplaceholder.typicode.com/todos')
    todos = todos_response.json()

    # Prepare the data structure
    data = {}

    # Populate data with tasks for each user
    for user in users:
        user_id = user['id']
        username = user['username']
        data[user_id] = []

        for todo in todos:
            if todo['userId'] == user_id:
                task_info = {
                    "username": username,
                    "task": todo['title'],
                    "completed": todo['completed']
                }
                data[user_id].append(task_info)

    return data


def export_to_json(data, filename='todo_all_employees.json'):
    with open(filename, 'w') as json_file:
        json.dump(data, json_file, indent=4)


if __name__ == '__main__':
    data_fetch = fetch_data()
    export_to_json(data_fetch)
