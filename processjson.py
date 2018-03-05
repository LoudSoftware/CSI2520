import json
from pprint import pprint

data = json.load(open('wading-pools.json'))

generalData = []


def processToGeneral():
    features = data['features']

    for item in features:
        coordinates = item['geometry']['coordinates']
        name = item['properties']['NAME']
        pool = {
            "name": name,
            "coordinates": coordinates
        }
        generalData.append(pool)

    pprint(generalData)


def processToJSON():
    print('__Begin json conversion__')
    with open('wading-pools-filtered.json', 'w') as outfile:
        json.dump(generalData,outfile,ensure_ascii=False)

def processToProlog():
    print('__Begin Prolog conversion__')
    with open('wading-pools-filtered.pl','w') as outfile:
        for item in generalData:
            out = "Pool(" + '"' + item['name'] + '"' + "," + str(item['coordinates'][0]) + "," + str(item['coordinates'][1]) + ")." + "\n"
            print(out)
            outfile.write(out)
        



if __name__ == '__main__':
    processToGeneral()
    processToJSON()
    processToProlog()