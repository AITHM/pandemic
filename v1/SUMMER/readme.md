
# Airport, airline and route data

https://openflights.org/data.html

# Airport database

As of January 2017, the OpenFlights Airports Database contains over 10,000 airports, train stations and ferry terminals spanning the globe, as shown in the map above. Each entry contains the following information:

- Airport ID: Unique OpenFlights identifier for this airport.
- Name: Name of airport. May or may not contain the City name.
- City: Main city served by airport. May be spelled differently from Name.
- Country: Country or territory where airport is located. See countries.dat to - cross-reference to ISO 3166-1 codes.
- IATA: 3-letter IATA code. Null if not assigned/unknown.
- ICAO: 4-letter ICAO code. Null if not assigned.
- Latitude: Decimal degrees, usually to six significant digits. Negative is South, - positive is North.
- Longitude: Decimal degrees, usually to six significant digits. Negative is West, - positive is East.
- Altitude: In feet.
- Timezone: Hours offset from UTC. Fractional hours are expressed as decimals, eg. - India is 5.5.
- DST: Daylight savings time. One of E (Europe), A (US/Canada), S (South America), O (- Australia), Z (New Zealand), N (None) or U (Unknown). See also: Help: Time
- Tz database time zone: Timezone in "tz" (Olson) format, eg. "America/Los_Angeles".
- Type: Type of the airport. Value "airport" for air terminals, "station" for train stations, "port" for ferry terminals and "unknown" if not known. In airports.csv, only type=airport is included.
- Source: Source of this data. "OurAirports" for data sourced from OurAirports, "Legacy" for old data not matched to OurAirports (mostly DAFIF), "User" for unverified user contributions. In airports.csv, only source=OurAirports is included.

The data is UTF-8 (Unicode) encoded.

Note: Rules for daylight savings time change from year to year and from country to country. The current data is an approximation for 2009, built on a country level. Most airports in DST-less regions in countries that generally observe DST (eg. AL, HI in the USA, NT, QL in Australia, parts of Canada) are marked incorrectly.

Sample entries:

```
507,"London Heathrow Airport","London","United Kingdom","LHR","EGLL",51.4706,-0.461941,83,0,"E","Europe/London","airport","OurAirports"
26,"Kugaaruk Airport","Pelly Bay","Canada","YBB","CYBB",68.534401,-89.808098,56,-7,"A","America/Edmonton","airport","OurAirports"
3127,"Pokhara Airport","Pokhara","Nepal","PKR","VNPK",28.200899124145508,83.98210144042969,2712,5.75,"N","Asia/Katmandu","airport","OurAirports"
8810,"Hamburg Hbf","Hamburg","Germany","ZMB",\N,53.552776,10.006683,30,1,"E","Europe/Berlin","station","User"
```

Download: airports.dat (Airports only, high quality)
Download: airports-extended.dat (Airports, train stations and ferry terminals, including user contributions)

If you'd like an even more thorough database, with extensive coverage of airstrips, heliports and other places of less interest for commercial airline frequent flyers, do check out OurAirports, whose public domain database covers over 40,000 places to fly from.

## Airline database

As of January 2012, the OpenFlights Airlines Database contains 5888 airlines. Each entry contains the following information:

- Airline ID: Unique OpenFlights identifier for this airline.
- Name: Name of the airline.
- Alias: Alias of the airline. For example, All Nippon Airways is commonly known as - "ANA".
- IATA: 2-letter IATA code, if available.
- ICAO: 3-letter ICAO code, if available.
- Callsign: Airline callsign.
- Country: Country or territory where airline is incorporated.
- Active: "Y" if the airline is or has until recently been operational, "N" if it is - defunct. This field is not reliable: in particular, major airlines that stopped flying - long ago, but have not had their IATA code reassigned (eg. Ansett/AN), will incorrectly show as "Y".

The data is ISO 8859-1 (Latin-1) encoded. The special value \N is used for "NULL" to indicate that no value is available, and is understood automatically by MySQL if imported.

Notes: Airlines with null codes/callsigns/countries generally represent user-added airlines. Since the data is intended primarily for current flights, defunct IATA codes are generally not included. For example, "Sabena" is not listed with a SN IATA code, since "SN" is presently used by its successor Brussels Airlines.

Sample entries:
```
324,"All Nippon Airways","ANA All Nippon Airways","NH","ANA","ALL NIPPON","Japan","Y"
412,"Aerolineas Argentinas",\N,"AR","ARG","ARGENTINA","Argentina","Y"
413,"Arrowhead Airways",\N,"","ARH","ARROWHEAD","United States","N"
```

Download: airlines.dat (~400 KB)


## Route database

As of January 2012, the OpenFlights/Airline Route Mapper Route Database contains 59036 routes between 3209 airports on 531 airlines spanning the globe, as shown in the map above. Each entry contains the following information:

- Airline: 2-letter (IATA) or 3-letter (ICAO) code of the airline.
- Airline ID: Unique OpenFlights identifier for airline (see Airline).
- Source airport: 3-letter (IATA) or 4-letter (ICAO) code of the source airport.
- Source airport ID: Unique OpenFlights identifier for source airport (see Airport)
- Destination airport: 3-letter (IATA) or 4-letter (ICAO) code of the destination airport.
- Destination airport ID: Unique OpenFlights identifier for destination airport (see - Airport)
- Codeshare: "Y" if this flight is a codeshare (that is, not operated by Airline, but - another carrier), empty otherwise.
- Stops: Number of stops on this flight ("0" for direct)
- Equipment: 3-letter codes for plane type(s) generally used on this flight, separated by spaces

The data is ISO 8859-1 (Latin-1) encoded. The special value \N is used for "NULL" to indicate that no value is available, and is understood automatically by MySQL if imported.

Notes:

- Routes are directional: if an airline operates services from A to B and from B to A, both A-B and B-A are listed separately.

- Routes where one carrier operates both its own and codeshare flights are listed only once.


Sample entries:

```
BA,1355,SIN,3316,LHR,507,,0,744 777
BA,1355,SIN,3316,MEL,3339,Y,0,744
TOM,5013,ACE,1055,BFS,465,,0,320
```

Download: routes.dat (~2 MB)

OpenFlights offers only airport, airline and route data; we do not have any other data available. We also do not have historical data older than 2009.

Some alternative commercial sources of data include:

- Cleartrip: airfares

- FlightAware: flight tracking
- FlightStats: schedules, flight tracking, historical data
- FlightWise: flight tracking

If you or a website you know of offers any of these for free, please let us know!

## Licensing and disclaimer

The OpenFlights Airport, Airline and Route Databases are made available under the Open Database License. Any rights in individual contents of the database are licensed under the Database Contents License. In short, these mean that you are welcome to use the data as you wish, if and only if you both acknowledge the source and and license any derived works made available to the public with a free license as well.

Licenses for commercial use of data or derived images are available on request. Most simple cases, for example use of an image within a book or other printed publication, are granted for a flat fee of US$100. Please contact us for details.

Airport data derived OurAirports and DAFIF, as well as route data from Airline Route Mapper, is in the public domain. Airline data derived from Wikipedia may be subject to the GNU Free Documentation License. Whether these databases pass the threshold of originality and are thus copyrightable in the United States is an open question, and Contentshare does not assert the validity or lack thereof of such a claim.

This data is not suitable for navigation. OpenFlights does not assume any responsibility whatsoever for its accuracy, and consequently assumes no liability whatsoever for results obtained or loss or damage incurred as a result of application of the data. OpenFlights expressly disclaims all warranties, expressed or implied, including but not limited to implied warranties of merchantability and fitness for any particular purpose.

Any corrections will be gratefully received.

## Sources

Airport base data was generated by from DAFIF (October 2006 cycle) and OurAirports, plus timezone information from EarthTools. All DST information added manually. Significant revisions and additions made by the users of OpenFlights.

Airline data was extracted directly from Wikipedia's gargantuan List of airlines. Significant revisions and additions made by the users of OpenFlights.

Route data is maintained by and imported directly from Airline Route Mapper. Duplicate entry removal and cross-referencing to airport/airline IDs by OpenFlights.




