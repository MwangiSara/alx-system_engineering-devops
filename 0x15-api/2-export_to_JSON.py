#!/usr/bin/python3
"""
This module fetches and displays the TODO list progress of a given
employee from a REST API. It also exports the data to a JSON file.
"""

import json
import requests
import sys


def get_employee_todo_progress(employee_id):
    """
    Fetches and displays the TODO list progress of
    a given employee from a REST API.
    Also exports the data to a JSON file.
    Args:
    :param employee_id: The ID of the employee
    """
    # Base URL for the API
    base_url = "https://jsonplaceholder.typicode.com"

    # Fetch employee data
    employee_url = f"{base_url}/users/{employee_id}"
    employee_response = requests.get(employee_url)

    if employee_response.status_code != 200:
        print(f"Error: Employee with ID {employee_id} not found.")
        return

    employee = employee_response.json()
    employee_name = employee.get("name")

    # Fetch todos data
    todos_url = f"{base_url}/todos?userId={employee_id}"
    todos_response = requests.get(todos_url)
    todos = todos_response.json()

    # Calculate the number of completed tasks and total tasks
    total_tasks = len(todos)
    done_tasks = [task for task in todos if task.get("completed")]
    number_of_done_tasks = len(done_tasks)

    # Print the employee's TODO list progress
    print("Employee {} is done with tasks({}/{}):".format(
        employee_name, number_of_done_tasks, total_tasks))
    for task in done_tasks:
        print(f"\t {task.get('title')}")

    # Prepare JSON data
    json_data = {str(employee_id): []}
    for task in todos:
        task_data = {
            "task": task.get("title"),
            "completed": task.get("completed"),
            "username": employee.get("username")
        }
        json_data[str(employee_id)].append(task_data)

    # Export to JSON
    json_filename = f"{employee_id}.json"
    with open(json_filename, mode='w') as json_file:
        json.dump(json_data, json_file)
    print(f"Data exported to {json_filename}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <employee_id>")
    else:
        try:
            employee_id = int(sys.argv[1])
            get_employee_todo_progress(employee_id)
        except ValueError:
            print("Error: Employee ID must be an integer.")
