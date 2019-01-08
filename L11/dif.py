import sys

with open("prac6.c", "r") as f:
    original = f.read()

with open("prac6_res.c", "r") as f:
    res = f.read()

print(original == res)