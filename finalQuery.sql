use sw30;
go

select Films.title,People.name,People.birth_year from People inner join FilmPerson on People.url = FilmPerson.person inner join Films on Films.url = FilmPerson.film where People.birth_year in(select min(People.birth_year) oldestCharacterBirthYear from People inner join FilmPerson on People.url = FilmPerson.person inner join Films on Films.url = FilmPerson.film where People.birth_year != -1 group by Films.title)

