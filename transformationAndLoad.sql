create database sw30;
go
use sw30;
go
CREATE TABLE People(name varchar(255), height float, mass float,hair_color varchar(255),skin_color varchar(255),eye_color varchar(255),birth_year float,gender varchar(255),url varchar(255) PRIMARY KEY NOT NULL,StartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL,EndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL,PERIOD FOR SYSTEM_TIME (StartTime,EndTime)) WITH (SYSTEM_VERSIONING = ON(HISTORY_TABLE = dbo.PeopleHistory38));

CREATE TABLE Films(title varchar(255), episode_id varchar(255), director varchar(255),producer varchar(255),release_date varchar(255),url varchar(255) PRIMARY KEY NOT NULL,StartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL,EndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL,PERIOD FOR SYSTEM_TIME (StartTime,EndTime)) WITH (SYSTEM_VERSIONING = ON(HISTORY_TABLE = dbo.filmsHistory38));

CREATE TABLE FilmPerson(film varchar(255) NOT NULL,person varchar(255) NOT NULL,CONSTRAINT filmPersonH_pk PRIMARY KEY (film, person),StartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL,EndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL,PERIOD FOR SYSTEM_TIME (StartTime,EndTime)) WITH (SYSTEM_VERSIONING = ON(HISTORY_TABLE = dbo.filmPersonHistory38));

INSERT INTO People (name, height , mass ,hair_color,skin_color ,eye_color,birth_year,gender,url) SELECT name, height , mass ,hair_color,skin_color ,eye_color,birth_year,gender,url FROM OPENROWSET (BULK '/home/administrator/checkATrade/people.json', SINGLE_CLOB) as j CROSS APPLY OPENJSON(BulkColumn) WITH( name varchar(255), height float, mass float,hair_color varchar(255),skin_color varchar(255),eye_color varchar(255),birth_year float,gender varchar(255),url varchar(255) );

INSERT INTO FilmPerson  (film,person) SELECT film,person FROM OPENROWSET (BULK '/home/administrator/checkATrade/filmPerson.json', SINGLE_CLOB) as j CROSS APPLY OPENJSON(BulkColumn) WITH( film varchar(255),person varchar(255) );

INSERT INTO Films (title, episode_id, director,producer,release_date,url) SELECT title, episode_id, director,producer,release_date,url FROM OPENROWSET (BULK '/home/administrator/checkATrade/films.json', SINGLE_CLOB) as j CROSS APPLY OPENJSON(BulkColumn) WITH( title varchar(255), episode_id varchar(255), director varchar(255),producer varchar(255),release_date varchar(255),url varchar(255) );


