import csv
import json

#Import Files

turkey_kurd_raw = [] #init list

with open('turkey_kurdistan.json') as file:
    turkey_kurd_raw = json.load(file)

print(type(turkey_kurd_raw[1]))