import datetime as dt
from airflow import DAG
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator

# Конфигурация DAG
OWNER = "e.erokhin"

args = {
    'owner': OWNER,                         # Владелец DAG — чаще для логирования и уведомлений
    'start_date': dt.datetime(2025, 11, 20),     # Дата, с которой начинается выполнение DAG
    'retries': 2,                               # Количество повторных попыток при неудаче задачи
    'retry_delay': dt.timedelta(seconds=10),    # Интервал между повторными попытками
}


def my_task(**context):
    print(context)


with DAG(
         dag_id='test_context_dag',
         schedule_interval='@daily',
         default_args=args
         ) as dag:
    
    start = EmptyOperator(
        task_id="start",)

    test = PythonOperator(
        task_id='test_task',
        python_callable=my_task,
        )
    end = EmptyOperator(
        task_id="end",
    )

    start >> test >> end

