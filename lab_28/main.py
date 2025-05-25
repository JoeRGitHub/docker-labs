import os
import time

file_path = "/app/counter_data/counter.txt"

# Check if the counter file exists, and read the current count
if os.path.exists(file_path):
    with open(file_path, "r") as file:
        count = int(file.read())
else:
    count = 0

while True:
    count += 1
    with open(file_path, "w") as file:
        file.write(str(count))

    print(f"Count updated: {count}")
    time.sleep(5)
