import json
from pprint import pprint

data = json.load(open('wading-pools.json'))

def processToJSON():
    filtered = {}

    features = data['features']

    for item in features:
        coordinates = item['geometry']['coordinates']
        name = item['properties']['NAME']

        filtered[name] = coordinates

    pprint(filtered)

    with open('wading-pools-filtered.json', 'w') as outfile:
        json.dump(filtered, outfile)

if __name__ == '__main__':
    processToJSON()