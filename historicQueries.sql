use sw30;

INSERT INTO People(name , height , mass ,hair_color ,skin_color ,eye_color ,birth_year ,gender ,url )
values("Nzinga", "172", "77","black","black","black",22,"male","https://swapi.dev/api/people/84/")

UPDATE People
SET height = 179
WHERE url = "https://swapi.dev/api/people/84/";


UPDATE People
SET height = 180
WHERE url = "https://swapi.dev/api/people/84/";


select * from dbo.PeopleHistory34 where starttime <'2021-11-23 01:15:14.5527818'

