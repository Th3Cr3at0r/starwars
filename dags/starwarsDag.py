from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta

with DAG(dag_id='starwarsDag2', schedule_interval=None, start_date=datetime(2021, 1, 1), catchup=False) as dag:
    extractJsonFiles = BashOperator(task_id='ExtractJsonFiles', bash_command='python /home/administrator/checkATrade/extractData.py')
    transformAndLoadToSqlServer = BashOperator(task_id='transformAndLoadToSqlServer', bash_command='sqlcmd -U SA -P "Cats2Dogs33" -i /home/administrator/checkATrade/transformationAndLoad.sql')
    extractJsonFiles >> transformAndLoadToSqlServer
