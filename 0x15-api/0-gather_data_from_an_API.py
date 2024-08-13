#!/usr/bin/python3

"""
This module returns info on the progress of a todo list assigned to an employee
identified by employee id from a dataset containing various employees
"""

import requests
import sys


if __name__ == "__main__":
    url_header = 'https://jsonplaceholder.typicode.com/'
    empl_id = sys.argv[1]
    empl_url = '{}users/{}'.format(url_header, empl_id)
    empl_response = requests.get(empl_url)
    empl_name = empl_response.json().get('name')

    todoList_url = '{}todos?userId={}'.format(url_header, empl_id)
    todoList_response = requests.get(todoList_url)
    todos = todoList_response.json()
    done_todos = []
    all_todos = len(todos)

    for todo in todos:
        if todo.get('completed'):
            done_todos.append(todo)
    completed = len(done_todos)

    print("Employee {} is done with tasks({}/{}):"
          .format(empl_name, completed, all_todos))

    for done_todo in done_todos:
        print("\t {}".format(done_todo.get('title')))
