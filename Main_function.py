import csv
import json

#Import Files

turkey_kurd_raw = [] #init list

with open('turkey_kurdistan.json') as file: #write to list
    turkey_kurd_raw = json.load(file)


#Produce Json file

select_vars = ["year","country","side_a","side_b","deaths_a","deaths_b", "deaths_civilians"] #add select_vars/select variables
turkey_kurd_filt = [] #init list for filtered json


for incident in turkey_kurd_raw: #copy key:value pairs with key in header to filt.json

    #Create a temporay dict, add keys and values
    temp = {} 
    for header in select_vars:
        temp[header] = incident[header]

    #Add temp as new item to filt
    turkey_kurd_filt.append(temp)



#Create filtered csv
with open('kurd_kurdistan.csv', 'w') as file:
 
    writer = csv.DictWriter(file, fieldnames=select_vars, lineterminator='\n', delimiter=',')
    writer.writeheader()

    for incident in turkey_kurd_filt:
        writer.writerow(incident)

print('Done')

#Checking for countries other that turkey

counter = 0
for incident in turkey_kurd_filt: #run filtered to print and count up
    if incident['country'] != 'Turkey':
        print(incident['country'])
        counter += 1
print(counter)

