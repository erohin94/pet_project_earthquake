## Начальные настройки - создание проекта

Создаем папку с проектом на гитхабе. 

Добавил питоновский gitignore и MIT лицензию.

<img width="882" height="789" alt="image" src="https://github.com/user-attachments/assets/a90678fa-88cc-4105-ae90-f6417be3525a" />

Создаю локальную папку на своем компьютере, например `C:\Users\erohi\Desktop\de_project`

Открываю терминал и перехожу в папку `cd C:\Users\erohi\Desktop\de_project`

Клонирую репозиторий `git clone git@github.com:erohin94/pet_project_earthquake.git`

<img width="1237" height="546" alt="image" src="https://github.com/user-attachments/assets/500dd782-ab81-4b35-9b6b-e4dc7cf02b85" />

<img width="763" height="147" alt="image" src="https://github.com/user-attachments/assets/30ff7da1-1f9b-4986-9f20-86327b918f0d" />

Видим как удаленныйрепозиторий склонировался в локальную папку.

<img width="621" height="154" alt="image" src="https://github.com/user-attachments/assets/c99a0e74-63de-4994-ba95-3ffe80795ded" />

## Проверяю работоспособность локального и удаленного репозитория.

Проверяю версию git `git --version`

<img width="386" height="32" alt="image" src="https://github.com/user-attachments/assets/00827df4-81f2-43e4-bbb3-927eba29df32" />

Задаю имя пользлвателя и почту, далее делаю проверку

```
git config --global user.name "Ваше имя"
git config --global user.email "email@domain.com"

git config user.email
git config user.name
```

<img width="686" height="147" alt="image" src="https://github.com/user-attachments/assets/4d228749-c507-49b3-8577-66253c14aadd" />

Создаю локально тестовый файл `test_file.txt`

<img width="622" height="194" alt="image" src="https://github.com/user-attachments/assets/18dfb0b7-1585-4962-a24c-7dc0822c5f35" />

Пробую его отправить в удаленный репозиторий, но перед отправкой, если в удаленном репозитории были какие либо изменения, их надо сначала добавить в локальный.

Сначала подтягиваем изменения с удалённого репозитория: `git pull origin main`

<img width="700" height="213" alt="image" src="https://github.com/user-attachments/assets/ffc16e18-8199-4317-85a8-18617b338261" />

Добавить файлы: `git add .`

Сделать коммит: `git commit -m "Тестовый коммит"`

<img width="737" height="101" alt="image" src="https://github.com/user-attachments/assets/c3c46477-aa5b-43da-9974-e1c46a848d0d" />

Затем пушим: `git push origin main`

<img width="617" height="165" alt="image" src="https://github.com/user-attachments/assets/a6e44861-6c3b-40de-b3b0-f2eafbeda88b" />

Как видим, файл добавлен в удаленный репозиторий.

<img width="1309" height="396" alt="image" src="https://github.com/user-attachments/assets/6776b1a3-feeb-4a0c-9d96-140827d946a6" />

## Создание виртуального окружения

Открываю VS Code и создаю виртуальное окружение: `python -m venv venv`

Активирую виртуальное окружение: `venv\Scripts\activate`

<img width="851" height="181" alt="image" src="https://github.com/user-attachments/assets/96c9049f-54cf-45c4-9f53-ef8511eac1e9" />

Как видно, на текущий момент абсолютно пустое виртуальное окружение

<img width="578" height="88" alt="image" src="https://github.com/user-attachments/assets/e66c1507-8288-405d-a62d-294075f94a8c" />

## Разворачивание инфраструктуры

В services в .yaml файле были добавлены сервисы postgres_dwh, minio, metabase

Так же в переменную `_PIP_ADDITIONAL_REQUIREMENTS: ${_PIP_ADDITIONAL_REQUIREMENTS:-duckdb}` был добавлен `duckdb`. Понадобится далее. Без него будет ошибка в UI Airflow.

<img width="803" height="260" alt="image" src="https://github.com/user-attachments/assets/b452b61d-e789-4a37-b8e1-3cc94eeb8525" />

Возникает из за того что, у меня Airflow изолирован, соответственно он не знает о моем виртуальном окружении venv, и то что я устанваливаю в виртуальное окружение venv, например установил в venv модуль duckdb (далее будет описано про установку).
Airflow в докре не знает об этом, поэтому нам необходимо прописать в `_PIP_ADDITIONAL_REQUIREMENTS: ${_PIP_ADDITIONAL_REQUIREMENTS:-duckdb}` все зависимости, которые должны быть установлены внутри контейнера. Это гарантирует, что DAG и задачи смогут использовать установленные пакеты без ошибок импорта.  

Выполняю команду: `docker-compose up -d`

Проверяю: `docker ps`

Как видно сервисы стартанули

<img width="1862" height="208" alt="image" src="https://github.com/user-attachments/assets/2bd9ee89-f7f5-4178-872d-d980e7153c9e" />

В локальной директории были созданы автоматически папки: dags, logs и тд

<img width="623" height="359" alt="image" src="https://github.com/user-attachments/assets/8a61e056-80d2-4ae2-af6e-af4597c5c76d" />

## Запуск Airflow

Чтобы увидеть интерфейс Airflow, открыть браузер и перейти по адресу http://127.0.0.1:8080/

Если все прошло по плану, то появится окно для ввода имени пользователя и пароля. Вводим в оба окошка airflow и подтверждаем.

<img width="1898" height="372" alt="image" src="https://github.com/user-attachments/assets/8d3ef726-4098-4459-b222-6ad2679aac5d" />

## Запуск Minio

Чтобы увидеть интерфейс Minio, открыть браузер и перейти по адресу http://127.0.0.1:9001

Войти в UI интерфейс с учетными данными пользователя. Вводим в оба окошка minioadmin

<img width="1890" height="336" alt="image" src="https://github.com/user-attachments/assets/f542816e-7023-45d4-8104-f4564298369d" />

Создаем бакет

<img width="1893" height="660" alt="image" src="https://github.com/user-attachments/assets/4dc88c72-208b-4994-97d3-6531fe937c48" />

Сохраняем ключи которые будем использовать для подключения к бакету.

<img width="1893" height="792" alt="image" src="https://github.com/user-attachments/assets/f0d49609-bf00-4a04-8e3c-97491255fa52" />

<img width="1156" height="646" alt="image" src="https://github.com/user-attachments/assets/b0dc8851-2884-4f23-87bb-1c27b6c9111a" />

Создаю файлик cred.py в котором будут ключи. В гит хранить его не будем.

<img width="938" height="389" alt="image" src="https://github.com/user-attachments/assets/20401d17-14f0-4e5c-bd94-602122ade746" />

В рамках S3 access ключ можно показывать и он никак не работает без секретного ключа.

В data у нас сейчас начали записываться мета файлы, его версионировать не будем, поэтому добавим в .gitignore

Открываю .gitignore и в конце прописываю

```
#Project
data/
logs/
cred.py
```

Эти файлы теперь не будут добавляться в удаленный репо на гитхаб

## Запуск Metabase

Metabase: http://localhost:3000

## Создание первого DAG

Первый даг будет грузить сырые данные из API и складывать в S3 `raw_from_api_to_s3.py`

Airflow сейчас работает в докере, у докера есть свое виртуальное окружение которое изолировано от моего локального компьютера.

В моем виртуальном окружении venv сейчас установлен только pip.

Чтобы сравнять виртуальное окружение между Airflow и моей локальной машиной, необходимо скачать пакет в мое виртуальное окружение которое запущено в VsCode.

Прописываю в поисковике pipy apache airflow и скачиваю версию 2.10.5 [ссылка](https://pypi.org/project/apache-airflow/#history)

<img width="584" height="99" alt="image" src="https://github.com/user-attachments/assets/608ba9d6-5004-45ba-a5ff-38dc7c257d17" />

Если сечас в .py файле прописать `from airflow import DAG`, то увидим подчеркивание

<img width="203" height="26" alt="image" src="https://github.com/user-attachments/assets/d03e4540-5d18-48d3-9900-417c6832d1c2" />

Это говорит о том что данное виртуальное окружение не знает что такое Airflow и что такое DAG. 

Для этого устанавливаем: `pip install apache-airflow==2.10.5` в наше виртуальное окружение.

Теперь после установки, если выделить DAG в импорте и нажать CTRL то будет видна документация.

<img width="825" height="322" alt="image" src="https://github.com/user-attachments/assets/86218e23-0c7a-44b0-ac27-3e1b409e2674" />

Так же можно и провалится в airflow.

*(Изначально при наведении на DAG, не удавалось видеть документацию, так как в VS Code не был выбран интерпретатор Python для проекта.
Из-за этого Pylance и Intellisense показывали Any, потому что они не видели установленные пакеты в виртуальном окружении.
После выбора правильного интерпретатора Python (в моём случае venv проекта) автодополнение и docstring для DAG начали работать корректно.)*

Так же устанавливаю duckdb [ссылка](https://pypi.org/project/duckdb/1.2.2/)

Ставлю версию: `pip install duckdb==1.2.2`

Пишу код в `raw_from_api_to_s3.py`

```
import logging

import duckdb
import pendulum # Для работы с датами
from airflow import DAG
from airflow.models import Variable
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator

# Конфигурация DAG
OWNER = "e.erokhin"
DAG_ID = "raw_from_api_to_s3"

# Используемые таблицы в DAG
LAYER = "raw"
SOURCE = "earthquake"

# S3
ACCESS_KEY = Variable.get("access_key")
SECRET_KEY = Variable.get("secret_key")

LONG_DESCRIPTION = """
# LONG DESCRIPTION
"""

SHORT_DESCRIPTION = "SHORT DESCRIPTION"

args = {
    "owner": OWNER,
    "start_date": pendulum.datetime(2025, 11, 12, tz="Europe/Moscow"),
    "catchup": True,
    "retries": 3,
    "retry_delay": pendulum.duration(hours=1),
}


def get_dates(**context) -> tuple[str, str]:
    """"""
    start_date = context["data_interval_start"].format("YYYY-MM-DD")
    end_date = context["data_interval_end"].format("YYYY-MM-DD")

    return start_date, end_date


def get_and_transfer_api_data_to_s3(**context):
    """"""

    start_date, end_date = get_dates(**context)
    logging.info(f"💻 Start load for dates: {start_date}/{end_date}")
    con = duckdb.connect()

    #con.sql(
        #f"""
        #SET TIMEZONE='UTC';
        #INSTALL httpfs;
        #LOAD httpfs;
        #SET s3_url_style = 'path';
        #SET s3_endpoint = 'minio:9000';
        #SET s3_access_key_id = '{ACCESS_KEY}'; 
        #SET s3_secret_access_key = '{SECRET_KEY}';
        #SET s3_use_ssl = FALSE;

        #COPY
        #(
            #SELECT
                #*
            #FROM
                #read_csv_auto('https://earthquake.usgs.gov/fdsnws/event/1/query?format=csv&starttime={start_date}&endtime={end_date}') AS res
        #) TO 's3://prod/{LAYER}/{SOURCE}/{start_date}/{start_date}_00-00-00.gz.parquet';

       #""",
    #)
    con.sql(
    f"""
    SET TIMEZONE='UTC';
    INSTALL httpfs;
    LOAD httpfs;

    SET s3_url_style='path';
    SET s3_endpoint='minio:9000';
    SET s3_access_key_id='{ACCESS_KEY}';
    SET s3_secret_access_key='{SECRET_KEY}';
    SET s3_use_ssl=FALSE;

    COPY (
        SELECT *
        FROM read_csv_auto(
            'https://earthquake.usgs.gov/fdsnws/event/1/query?format=csv&starttime={start_date}&endtime={end_date}'
        )
    ) TO 's3://prod/{LAYER}/{SOURCE}/{start_date}/{start_date}_00-00-00.gz.parquet'
    (FORMAT PARQUET, COMPRESSION 'GZIP');
    """
)
    con.close()
    logging.info(f"✅ Download for date success: {start_date}")


with DAG(
    dag_id=DAG_ID,
    schedule_interval="0 5 * * *",
    default_args=args,
    tags=["s3", "raw"],
    description=SHORT_DESCRIPTION,
    concurrency=1,
    max_active_tasks=1,
    max_active_runs=1,
) as dag:
    dag.doc_md = LONG_DESCRIPTION

    start = EmptyOperator(
        task_id="start",
    )

    get_and_transfer_api_data_to_s3 = PythonOperator(
        task_id="get_and_transfer_api_data_to_s3",
        python_callable=get_and_transfer_api_data_to_s3,
    )

    end = EmptyOperator(
        task_id="end",
    )

    start >> get_and_transfer_api_data_to_s3 >> end
```

После чего обновляю UI Airflow и вижу ошибку:

<img width="814" height="295" alt="image" src="https://github.com/user-attachments/assets/365e0846-1f98-42cc-ab2e-1172198bad64" />

Ругается на то, что ключей не существует. Для этого перехожу в Admin->Variables и создаю новый атрибут:

<img width="780" height="444" alt="image" src="https://github.com/user-attachments/assets/0015274f-3e05-4e0b-8bc4-74d5ed3b2d6e" />

<img width="853" height="463" alt="image" src="https://github.com/user-attachments/assets/2653454e-64e8-4765-8fea-fd9a7b4a6a5f" />

<img width="1391" height="527" alt="image" src="https://github.com/user-attachments/assets/e30782a9-05b6-41c7-99eb-7eb10b2a44bc" />

Обновляю и вижу что появился даг и пропала ошибка

<img width="1889" height="402" alt="image" src="https://github.com/user-attachments/assets/35d482a3-1085-4609-aa85-1389a612fbf2" />

44:00
