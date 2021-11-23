import tools
    
def getRec(json):
    if( json['next'] != None ):
        #Obtaining the next url from the json
        url = json['next']
        # Using un verify connection before their ssl certificate expired
        response=tools.getFromUrl(url)
        next=response.json()
        #Adding result
        json['results'].extend(next['results'])
        #Updating previous and next to allow for further iterations
        json['previous']=next['previous']
        json['next']=next['next']
        getRec(json)
    return json
    
def getAll(resource):
    url =""
    if(resource == "people"):
        url = "https://swapi.dev/api/people/"
    elif(resource == "films"):
        url = "https://swapi.dev/api/films"
    else:
        url =""
    if(url != ""):
        #Performing the first iteration to commence the the recursive function getRec
        response = tools.getFromUrl(url)
        json=response.json()
        return getRec(json)
    return None

if __name__=="__main__":
    people=getAll("people")
    # Converting all birth years... knowning that they all BBY (Battle of Yavin)
    # Only keeping the numeric part 
    for result in people["results"]:
        if( result["birth_year"] == "unknown" ):
            result["birth_year"] = "-1"
        else:
            byL = len(result["birth_year"])
            result["birth_year"] = result["birth_year"][:byL-3]
        if( result["height"] == "unknown" ):
            result["height"] = "-1"
        else:
            result["height"] = result["height"].replace(',',"")
        if(result["mass"]== "unknown"):
            result["mass"]= "-1"
        else:
            result["mass"]=result["mass"].replace(',',"")


    filmPerson=[]
    #Producing a join table with film and person url
    for result in people["results"]:
        for film in result["films"]:
            dict={"film":film,"person":result["url"]}
            filmPerson.append(dict)

    films=getAll("films")

    tools.writeJson("/home/administrator/checkATrade/people.json",people["results"])
    tools.writeJson("/home/administrator/checkATrade/filmPerson.json",filmPerson)
    tools.writeJson("/home/administrator/checkATrade/films.json",films["results"])
