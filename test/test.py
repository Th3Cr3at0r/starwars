import math
import extractData as eD
import pyodbc

def test_getAllPeople():
   people=eD.getAll("people")
   assert len(people["results"]) == 82

def test_sqlServerPeopleJsonImport():
   conn_str = ("Driver={ODBC Driver 17 for SQL Server};"
            "Server=localhost;"
            "Database=sw30;"
            "UID=SA;"
            "PWD=Cats2Dogs33;")
   conn = pyodbc.connect(conn_str)
   cursor = conn.cursor()
   cursor.execute("SELECT * FROM People")
   res = cursor.fetchall()
   assert len(res) == 82
