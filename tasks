# Python Class Task

### Tasks

As group of 2 developers, you need to work on 2 features seperately, yet on the same repository. you work simuntaniously on the tasks below, while practicing communication and planning

- Create repo in github, and make main branch projected
    - repo => settings => branches => add classic branch protection rule | branch name pattern => main
    - choose 'Require a pull request before merging' and add 'Require approvals'

- Create 2 branches of the project:
    - branch named `initial_struct`
    - branch named `initial_app`

- In `initial_struct` branch, create README file
    - add name of the project
    - description what the project is about
    - links to
        - contributers
        - task
        - install - precise instruction how to install or use the project

- In `initial_struct` branch, create `src` folder and under it a tree of application stucture
    - `srv` : main application folder, with .py extention
    - `lib` : folder with libraries where the  features of the application will be set 
    - `env_verify.sh` :shel script that will check that all requirement for developing this project are satisfied, and in case it is not, suggests to install and configure it.
    - save the folder structure on remote git repository and create merge request, while other person in your team will validate your work
    
- Change to `initial_app` branch and validate that you have the folder structure in it
    - if not, do the `git pull` from main branch or `git pull` from `initial_struct` branch
    - create in `srv` folder, file named `app.py`
    - creare in `lib` folder, file name `lib.py`
    - creare in `lib` folder, file name `__init__.py`
    - verify that all the files have excutable permissions
    - copy python code below to `lib.py`
```py
def hello_name(name=user):
    return f'Hello {name}'

def goodbye_name(name=user):
    return f'Goobye {name}'
```
    - copy python code below to `__init__.py`
```py
from src.lib import lib
```
    - copy python code below to `app.py`
```py
import os
import sys
import time

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from src.lib import lib

user_name = input('[?] Please provide name: ')

hello_user_name_value = lib.hello_name(user_name)
goodbye_user_name_value = lib.goodbye_name(user_name)

print(f'[+] {hello_user_name_value}')
time.sleep(2)
print('[+] Running computing jobs')
time.sleep(2)
print('[+] Still computing')
time.sleep(2)
print('[+] Computations completed successfully')
time.sleep(2)
print(f'[+] {goodbye_user_name_value}')
```
    - run the `app.py` to check that application is running
    - verify that you are located in src folder
    - push code to `initial_app` branch
    - create merge request and verify code with your team mate
    - merge code and there needs to be a main branch with folder struct and application in it.






