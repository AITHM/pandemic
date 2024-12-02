"""
Read in OAGExcel for flight travel data to generate
a flight travel matrix.
"""

import json
import random
import pprint
import csv

import numpy
import xlrd
import pycountry
import geopy

import countrycoordinates

def make_unique_list(elements):
   result = []
   for e in elements:
       if e not in result:
           result.append(e)
   return result


def read_tsv_with_header(fname):
    result = []
    header = None
    with open(fname) as tsvin:
        tsvin = csv.reader(tsvin, delimiter='\t')
        for row in tsvin:
            if header is None:
                header = row
            else:
                result.append({k: v for k, v in zip(header, row)})
    return result


data_js_template = '''
define(function() {
  result = {{data}}
  return result
})
'''

def make_data_js(fname, data):
    out_text = data_js_template.replace('{{data}}', json.dumps(data))
    open(fname, 'w').write(out_text)


def symmetrize_matrix(matrix):
    for i in range(matrix.shape[0]):
        for j in range(matrix.shape[1]):
            if i != j:
                val = 0.5 * (matrix[i][j] + matrix[j][i])
                matrix[i][j] = val
                matrix[j][i] = val


def get_country_coordinates(country_name):
    geolocator = geopy.geocoders.Nominatim()
    location = geolocator.geocode(country_name)
    return location.latitude, location.longitude


def write_matrix_to_datajs(matrix, alpha2_from_i):

    symmetrize_matrix(matrix)
    eig_values, eig_vectors = numpy.linalg.eig(matrix)

    n = len(alpha2_from_i)

    def get_country_from_i(i):
        return pycountry.countries.get(alpha_2=alpha2_from_i[i])

    country_travel = []
    for i in range(n):
        row = []
        for j in range(n):
            country = get_country_from_i(j)
            row.append([country.alpha_3, matrix[i, j], country.numeric])
        country_travel.append(row)

    eigen = []
    for i in range(n):
        country = get_country_from_i(i)
        travel = int(eig_vectors[0][i] * eig_values[0])
        eigen.append([country.alpha_3, travel])

    coordinates_from_alpha2 = countrycoordinates.coordinates_from_alpha2
    countries = []
    for i in range(n):
        alpha_2 = alpha2_from_i[i]
        name = get_country_from_i(i).name
        if alpha_2 in coordinates_from_alpha2:
            country = coordinates_from_alpha2[alpha_2]
            coordinates = [
                float(country['Latitude (average)']),
                float(country['Longitude (average)'])]
        else:
            coordinates = None
        entry = {'name': name, 'coordinates': coordinates, 'id': country['Numeric code']}
        print(entry)
        countries.append(entry)

    make_data_js('data.js', {
        'travel': country_travel,
        'series': eigen,
        'countries': countries
    })

def extract_travel_matrix(oag_spreadsheet):
    """
    :param oag_spreadsheet: filename of OAG spreadsheet with flight data
    :return (travel_matrix, alpha2_to_i)
        travel_matrix: numpy matrix
        alpha2_to_i: dictionary from index to ISO-2 nation code
    """
    wb = xlrd.open_workbook(oag_spreadsheet)
    sheet = wb.sheet_by_index(0)

    # get country codes from spreadsheet
    codes = make_unique_list(map(lambda c: c.value, sheet.col(1)[1:]))

    # run through conversion for non-standard 2 letter codes
    def get_alpha_2(code):
        return 'RU' if code == 'R1' or code == 'R2' else code
    unique_alpha_2 = make_unique_list(sorted(map(get_alpha_2, codes)))

    # generate unique index for country based on alphabetic 2 letter ISO code
    i_from_code = {code: unique_alpha_2.index(get_alpha_2(code)) for code in codes}
    alpha2_from_i = {i: get_alpha_2(code) for code, i in i_from_code.items()}

    # grab travel matrix indexed to country ISO 2 letter code
    n_index = len(unique_alpha_2)
    travel_matrix = numpy.zeros((n_index, n_index))
    for i_row, row in enumerate(sheet.get_rows()):
        if i_row == 0:
            continue
        i_origin = i_from_code[row[1].value]
        i_dest = i_from_code[row[3].value]
        travel_matrix[i_origin][i_dest] += float(row[5].value)

    return travel_matrix, alpha2_from_i


make_data_js('names.js', read_tsv_with_header('world-country-names.tsv'))
matrix, alpha2_from_i = extract_travel_matrix('SUMMER/OAGinExcel.xlsx')
write_matrix_to_datajs(matrix, alpha2_from_i)
