import subprocess

for i in range(100):
    try:
        count = i*1000
        time = subprocess.check_output(["./prac6_keisoku", str(count)]).decode().replace("\r\n", "")
        print(f"{count}\t{time}")
    except subprocess.CalledProcessError as e:
        print(e)
        break

print("END")