

CREATE TABLE starwars4.People(name varchar(255), height varchar(255), mass varchar(255),hair_color varchar(255),skin_color varchar(255),eye_color varchar(255),birth_year float,gender varchar(255),url varchar(255) PRIMARY KEY NOT NULL,StartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL,EndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL,PERIOD FOR SYSTEM_TIME (StartTime,EndTime)) WITH (SYSTEM_VERSIONING = ON(HISTORY_TABLE = starwarsHistoric4.PeopleHistory));

CREATE TABLE starwars4.Films(title varchar(255), episode_id varchar(255), director varchar(255),producer varchar(255),release_date varchar(255),url varchar(255) PRIMARY KEY NOT NULL,StartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL,EndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL,PERIOD FOR SYSTEM_TIME (StartTime,EndTime)) WITH (SYSTEM_VERSIONING = ON(HISTORY_TABLE = starwarsHistoric4.filmsHistory));

CREATE TABLE starwars4.FilmPerson(film varchar(255) NOT NULL,person varchar(255) NOT NULL,CONSTRAINT filmPersonH_pk PRIMARY KEY (film, person),StartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL,EndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL,PERIOD FOR SYSTEM_TIME (StartTime,EndTime)) WITH (SYSTEM_VERSIONING = ON(HISTORY_TABLE = starwarsHistoric4.filmPersonHistory));


INSERT INTO starwars4.People SELECT import_data.* FROM OPENROWSET (BULK '/home/administrator/checkATrade/people.json', SINGLE_CLOB) as j CROSS APPLY OPENJSON(BulkColumn) WITH( name varchar(255), height varchar(255), mass varchar(255),hair_color varchar(255),skin_color varchar(255),eye_color varchar(255),birth_year float,gender varchar(255),url varchar(255) ) AS import_data;

INSERT INTO starwars4.Films SELECT import_data.* FROM OPENROWSET (BULK '/home/administrator/checkATrade/films.json', SINGLE_CLOB) as j CROSS APPLY OPENJSON(BulkColumn) WITH( title varchar(255), episode_id varchar(255), director varchar(255),producer varchar(255),release_date varchar(255),url varchar(255) ) AS import_data;

INSERT INTO starwars4.FilmPerson SELECT import_data.* FROM OPENROWSET (BULK '/home/administrator/checkATrade/filmPerson.json', SINGLE_CLOB) as j CROSS APPLY OPENJSON(BulkColumn) WITH( film varchar(255),person varchar(255) ) AS import_data;

