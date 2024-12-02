# https://opendata.socrata.com/dataset/Country-List-ISO-3166-Codes-Latitude-Longitude/mnkm-8ram/data

coordinates_from_alpha2 = {}

import csv

fname = 'Country_List_ISO_3166_Codes_Latitude_Longitude.csv'
with open(fname) as f:
    reader = csv.DictReader(f)
    for row in reader:
        coordinates_from_alpha2[row['Alpha-2 code']] = row

