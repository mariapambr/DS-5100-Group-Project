import requests
import json
import pandas as pd




#Headers for API authentication
headers = {
    'x-rapidapi-host': "meteostat.p.rapidapi.com",
    'x-rapidapi-key': "7a40a4bd10msha7682e079cabc32p19dcf9jsnbec60549ad95"
    }


#Find nearest station GET method
url = "https://meteostat.p.rapidapi.com/stations/nearby"

#Seattle Lat and Longitude
querystring = {"lat":"47.6062","lon":"-122.3321"}

response_station = requests.request("GET", url, headers=headers, params=querystring)

#ID 72793 for Seattle Airport
print(response_station.text)


#Hourly data GET method
url = "https://meteostat.p.rapidapi.com/stations/hourly"
#Query Parameter, no time zone
querystring = {"station":"72793","start":"2020-01-01","end":"2020-01-31"}


response_data = requests.request("GET", url, headers=headers, params=querystring)

data = pd.DataFrame.from_dict(response_data.json()['data'])




