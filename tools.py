import requests
import json as js
def getFromUrl(url):
    #return requests.get(url, verify = False)
	return requests.get(url)
    
def writeJson(filename,l):
	#Converting from a list to json string
	jsonString = js.dumps(l, indent=4)
	with open(filename, "w") as outfile:
		outfile.write(jsonString)

