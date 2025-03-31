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
