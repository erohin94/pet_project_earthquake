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

Был скачан оффициальный образ Airflow и в services в .yaml файле были добавлены сервисы postgres_dwh, minio, metabase

Так же в переменную `_PIP_ADDITIONAL_REQUIREMENTS: ${_PIP_ADDITIONAL_REQUIREMENTS:-duckdb}` был добавлен `duckdb`. Понадобится далее. Без него будет ошибка в UI Airflow.

<img width="803" height="260" alt="image" src="https://github.com/user-attachments/assets/b452b61d-e789-4a37-b8e1-3cc94eeb8525" />

Возникает из за того что, у меня Airflow изолирован, соответственно он не знает о моем виртуальном окружении venv, и то что я устанваливаю в виртуальное окружение venv, например установил в venv модуль duckdb (далее будет описано про установку).
Airflow в докре не знает об этом, поэтому нам необходимо прописать в `_PIP_ADDITIONAL_REQUIREMENTS: ${_PIP_ADDITIONAL_REQUIREMENTS:-duckdb}` все зависимости, которые должны быть установлены внутри контейнера. Это гарантирует, что DAG и задачи смогут использовать установленные пакеты без ошибок импорта.  

Так же перед запуском добавить папку `metabase` с докер файлом иначе будет ошибка при запуске сборки.

Выполняю команду: `docker-compose up -d`

Проверяю: `docker ps`

Как видно сервисы стартанули

<img width="1862" height="208" alt="image" src="https://github.com/user-attachments/assets/2bd9ee89-f7f5-4178-872d-d980e7153c9e" />

В локальной директории были созданы автоматически папки: dags, logs и тд

<img width="623" height="359" alt="image" src="https://github.com/user-attachments/assets/8a61e056-80d2-4ae2-af6e-af4597c5c76d" />

Так же запуск `docker-compose up -d` можно было делать в виртуальном окружении `venv`

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

## Подключение к PostgreSQL

<img width="980" height="809" alt="image" src="https://github.com/user-attachments/assets/2cbc983f-2be3-4507-96c6-145e7bd968b5" />

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
def get_dates(**context) -> tuple[str, str]:
    """"""
    start_date = context["data_interval_start"].format("YYYY-MM-DD")
    end_date = context["data_interval_end"].format("YYYY-MM-DD")

    return start_date, end_date
```

Функция `get_dates(**context)` принимает в себя атрибут в виде контекста. Контекст это основная концепция в Airflow, которая хранит в себе кучу разной информации. Это словарь со всей служебной информацией о текущем запуске DAG и задачи, автоматически передаваемый Airflow в каждую задачу.

Примерно вот так выглядит context. Если бы напечатал его в `PythonOperator`:

```
def my_task(**context):
    print(context)
```

То внутри было бы что-то типа:

```
{
  'ds': '2025-11-23',
  'ts': '2025-11-23T00:00:00+00:00',
  'data_interval_start': DateTime(2025, 11, 22),
  'data_interval_end': DateTime(2025, 11, 23),
  'dag_run': <DagRun ...>,
  'task': <Task ...>,
  'run_id': 'scheduled__2025-11-23T00:00:00Z',
  'ti': <TaskInstance>,
  ...
}
```

Это просто набор готовых значений, которые Airflow предоставляет.

В данном даге использую функцию get_dates(**context) чтобы доставать инфу о текущем запуске даг, а именно дату начала запуска и дату конца запуска, которые использую в дальнейшем.

Контекст рекомендуется использовать в 100% случаев, использование контекста необходимо для создания идемпотентности. 

**Идемпотентность (idempotency)** — это свойство операции, при котором повторный запуск даёт тот же результат, что и первый, и не приводит к дополнительным изменениям.

Так же в скрипте использую команду `COPY TO`

```
COPY
        (
            SELECT
                *
            FROM
                read_csv_auto('https://earthquake.usgs.gov/fdsnws/event/1/query?format=csv&starttime={start_date}&endtime={end_date}') AS res
        ) TO 's3://prod/{LAYER}/{SOURCE}/{start_date}/{start_date}_00-00-00.gz.parquet';
```

Это довольно простая команда, от куда скопировал COPY и куда вставил TO, в данном случае беру данные из апи и вставляю в бакет S3

Полностью код дага

```
import logging # Встроенный модуль Python для логирования

import duckdb # Создаю In-Memory БД
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
# Эта конструкция нужна, чтобы читать переменные, которые хранятся не в коде, а в Airflow UI / Airflow metadata DB.
ACCESS_KEY = Variable.get("access_key") # Это то что я прописываю в Admin->Variables в UI Airflow.
SECRET_KEY = Variable.get("secret_key") # Это то что я прописываю в Admin->Variables в UI Airflow

LONG_DESCRIPTION = """
# LONG DESCRIPTION
"""

SHORT_DESCRIPTION = "SHORT DESCRIPTION"

args = {
    "owner": OWNER,
    "start_date": pendulum.datetime(2025, 11, 20, tz="Europe/Moscow"),
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

    con.sql(
        f"""
        SET TIMEZONE='UTC';
        INSTALL httpfs;
        LOAD httpfs;
        SET s3_url_style = 'path';
        SET s3_endpoint = 'minio:9000';
        SET s3_access_key_id = '{ACCESS_KEY}';
        SET s3_secret_access_key = '{SECRET_KEY}';
        SET s3_use_ssl = FALSE;

        COPY
        (
            SELECT
                *
            FROM
                read_csv_auto('https://earthquake.usgs.gov/fdsnws/event/1/query?format=csv&starttime={start_date}&endtime={end_date}') AS res
        ) TO 's3://prod/{LAYER}/{SOURCE}/{start_date}/{start_date}_00-00-00.gz.parquet';

        """,)

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

Если кликнем на таску то увидим логи и то что загрузка завершена

<img width="1876" height="587" alt="image" src="https://github.com/user-attachments/assets/df41e43b-8766-48d8-a767-6e5fb63e2073" />

Так же увидим в MINIO

<img width="1889" height="447" alt="image" src="https://github.com/user-attachments/assets/d4a39c58-8e7c-4cb9-9b7c-8404b9eb2b68" />

<img width="1866" height="393" alt="image" src="https://github.com/user-attachments/assets/4849f7fb-eefd-4f74-b11f-694a2a1eacf8" />

Загрузка инкриментально за вчера. И все происходит идемпотентно.

То есть если очистим таск

<img width="1883" height="587" alt="image" src="https://github.com/user-attachments/assets/0ecbc965-a1bf-4d9c-a7d9-2356f3ae2cfa" />

<img width="1892" height="601" alt="image" src="https://github.com/user-attachments/assets/19c81c39-6f1b-46ba-a816-7b4c9060db73" />

То он перетрет данные и опять загрузит тоже самое что и было за эту дату.

И если посмотреть на данные за 20-11-2025 то они будут свежее (Last Modified) чем за 23-11-2025

<img width="1640" height="239" alt="image" src="https://github.com/user-attachments/assets/ec4aa90c-aaa7-4cf3-9ba6-d4359261b15a" />

<img width="1613" height="252" alt="image" src="https://github.com/user-attachments/assets/8b3e1d4d-9885-4617-b5ad-63609b344c6e" />


Тоесть благодаря контексту мы создали идемпотентность.

## Создание второго DAG

`raw_from_s3_to_pg.py`

В данном даге будет использоваться концепция сенсора `ExternalTaskSensor` — это сенсор в Apache Airflow, который ожидает завершения задачи в другом DAG. Сенсор (Sensor) в Apache Airflow — это специальный тип оператора, который ожидает выполнения определенного условия перед продолжением выполнения DAG. По структуре второй даг похож на первый даг.

Для начала создаю ключ `pg_password`. Перехожу в UI Airflow, Admin -> Variables

<img width="777" height="465" alt="image" src="https://github.com/user-attachments/assets/ea50d9fa-c62e-466f-86c3-aa51b4c018fe" />

Использую синтаксис DuckDB. Создаю `SECRET dwh_postgres`.

Это функции DuckDB для работы с внешними источниками данных и управления секретами.

SECRET позволяет безопасно хранить учетные данные для подключения к внешним системам:

```
CREATE SECRET dwh_postgres (
            TYPE postgres,
            HOST 'postgres_dwh',
            PORT 5432,
            DATABASE postgres,
            USER 'postgres',
            PASSWORD '{PASSWORD}'
        );
```

Что делает: Создает именованный секрет dwh_postgres с параметрами подключения к PostgreSQL. Хранит чувствительные данные (пароли) в зашифрованном виде. Исключает необходимость хранения паролей в открытом виде в коде.

Пароль забираю из UI Airflow с помощью `PASSWORD = Variable.get("pg_password")`

ATTACH подключает внешнюю базу данных как схему в текущей сессии DuckDB: `ATTACH '' AS dwh_postgres_db (TYPE postgres, SECRET dwh_postgres);`

Что делает: Подключается к PostgreSQL используя ранее созданный секрет `dwh_postgres`. Создает псевдоним `dwh_postgres_db` для удаленной БД. Позволяет работать с таблицами PostgreSQL как с локальными таблицами DuckDB.

Т.е код в `con.sql(.....)` делает следующее: Настраивает подключение к MinIO (S3-совместимое хранилище). Создает секрет для PostgreSQL DWH. Подключает PostgreSQL как внешнюю БД под именем `dwh_postgres_db`. Вставляет данные из DuckDB в таблицу PostgreSQL.

В UI Airflow -> Browse -> DAG Dependencies можно увидеть зависимость дагов.

<img width="820" height="287" alt="image" src="https://github.com/user-attachments/assets/56246e17-4df7-4439-94c7-b68f76ae5040" />

Тоесть даг `raw_from_s3_to_pg` зависит от дага `raw_from_api_to_s3` на основе сенсора `sensor_on_raw_layer`

Так же перед запуском дага, необходимо создать модель данных с которой будем работать. Для этого открываю DBeaver.

Создаем схемы:

```
CREATE SCHEMA stg;
CREATE SCHEMA ods;
CREATE SCHEMA dm;
```

<img width="256" height="147" alt="image" src="https://github.com/user-attachments/assets/7d1594a0-1b94-4e94-905e-34ba3dad072a" />

Создаю таблицы:

DDL ods.fct_earthquake:

```
DDL ods.fct_earthquake:

CREATE TABLE ods.fct_earthquake
(
	time varchar,
	latitude varchar,
	longitude varchar,
	depth varchar,
	mag varchar,
	mag_type varchar,
	nst varchar,
	gap varchar,
	dmin varchar,
	rms varchar,
	net varchar,
	id varchar,
	updated varchar,
	place varchar,
	type varchar,
	horizontal_error varchar,
	depth_error varchar,
	mag_error varchar,
	mag_nst varchar,
	status varchar,
	location_source varchar,
	mag_source varchar
)
```

Чтобы не тратить время, все типы привел к Varchar (Лучше так не делать).

Запускаем даг `raw_from_s3_to_pg`. Так же, делаю не ручной запуск. А просто проваливаюсь в даг и вижу как он отрабатывает. Как только начинает отрабатывать этот даг, он выполняет доп таску в виде сенсора.

<img width="1895" height="532" alt="image" src="https://github.com/user-attachments/assets/210b9739-4e5b-41e4-be43-44e7ae8d4878" />

Сенсор ждет состояние успеха для первого дага. Можно нажать External Dag и обратиться к тому дагу который сенсор смотрит.

<img width="1876" height="739" alt="image" src="https://github.com/user-attachments/assets/d09634ab-a4e7-4009-824c-8113f57f4e4e" />

Важное свойство сенсора в том что, если первый даг не отработал, то второй даг не начнет свою работу.

Видим как все отработало.

<img width="1857" height="612" alt="image" src="https://github.com/user-attachments/assets/88a32178-d16b-4d09-95f8-8be516c66bd2" />

Проверяю, добавились ли данные в postgre. Вижу, что добавлены необходимые даты и следующее количество строк

<img width="443" height="221" alt="image" src="https://github.com/user-attachments/assets/9cae81d1-f973-4449-93f3-484c5ac99ab2" />

<img width="264" height="163" alt="image" src="https://github.com/user-attachments/assets/176677b2-64b1-42bd-be6f-5941bedfc0c0" />

<img width="1894" height="368" alt="image" src="https://github.com/user-attachments/assets/570a7a3a-4911-41a4-8a97-b5780bb0c753" />

## Собираю витрину - третий DAG

`fct_count_day_earthquake.py`

Использую `SQLExecuteQueryOperator`. В данном скрипте не использую питоновских функций. Но структура дага такая же как и ранее. Есть переменные со слоями, соединиями и тд. В данном случае DuckDB и python никак не учитываются. Сейчас работаю только с postgre.

В коде так же использую сенсор, который ссылается на даг `external_dag_id="raw_from_s3_to_pg"` и занимается перегрузкой данных в postgre.

`task_id="drop_stg_table_before"` - Перед тем как создать витрину, мы создаем tmp таблицу 'task_id="create_stg_table"' в слое `stg` в котором будут хранится данные. 

Далее для идемпотентности использую `task_id="drop_from_target_table". Тоесть например у нас сейчас есть данные с 1 по 8 мая и мы хотим перегрузить данные за 5 мая, потому что у нас прилетили например какие то долеты или новые землетрясения. То мы просто перегружаем за 5 мая и для того чтобы исключить дублирование, мы удаляем именно этот день и вставляем его заново.

Делаю вставку `task_id="insert_into_target_table"`. Например если мы удалили 5 мая, то мы сразу его вставляем из временной таблицы и сразу удаляем временную таблицу `task_id="drop_stg_table_after"`

Перед запуском дагов надо создать коннект в UI Airflow -> Admin -> Connections

<img width="1874" height="917" alt="image" src="https://github.com/user-attachments/assets/edc1b735-bf1d-4afa-84e1-179fc06883a7" />

<img width="1872" height="455" alt="image" src="https://github.com/user-attachments/assets/ac5bc206-0295-48b1-bf01-74b924ffa9c9" />

С этого момента имею подключение к постгре, которое могу использовать в нескольких дагах. Вариантов подключения есть много.

Проваливаюсь в UI в `DAG: fct_count_day_earthquake` и запускаю. Может появится ошибка, так как не создана таблица.

<img width="1884" height="686" alt="image" src="https://github.com/user-attachments/assets/6556f9da-6ec2-480c-9fb2-4a07a36726b4" />

Для создания таблицы перехожу в дибивер и пишу.

DDL dm.fct_count_day_earthquake:

```
CREATE TABLE dm.fct_count_day_earthquake AS 
SELECT time::date AS date, count(*)
FROM ods.fct_earthquake
WHERE time::date = '2025-11-20'
GROUP BY 1
```
После создания проверяю и вижу данные

<img width="722" height="436" alt="image" src="https://github.com/user-attachments/assets/ef905f70-efde-415b-be0f-20eb2b4e0931" />

Теперь очищаю таску с ошибкой

<img width="1898" height="692" alt="image" src="https://github.com/user-attachments/assets/98b54f70-bdd8-4d8c-91b0-51e10d8ea9d4" />

Вижу что отработало

<img width="1892" height="708" alt="image" src="https://github.com/user-attachments/assets/6804aa3e-21be-40e7-bd60-cf9e3e24eb75" />

Обновляю и вижу те же самые числа, потому что у нас идемпотентность.

<img width="304" height="194" alt="image" src="https://github.com/user-attachments/assets/eb1069c8-5073-47aa-915f-8991017ac94b" />

Так же можно посмотреть граф

<img width="1906" height="677" alt="image" src="https://github.com/user-attachments/assets/fe6910b1-0c51-4baf-b2c3-e02f057675cb" />

Очистив таску за какую то дату можно посмотреть как работает идемпотентность. Данные будут одинаковыми.

<img width="1869" height="680" alt="image" src="https://github.com/user-attachments/assets/ad3ac7da-8195-4c8d-86c2-2d8728c613a9" />

Так же создаю еще один даг `fct_avg_day_earthquake.py`

Пример SQL запроса для создания таблицы

DDL dm.fct_avg_day_earthquake:

```
CREATE TABLE dm.fct_avg_day_earthquake AS
SELECT time::date AS date, avg(mag::float)
FROM ods.fct_earthquake
WHERE time::date = '2025-11-20'
GROUP BY 1 
```
Так же можно посмотреть зависимоть дагов

<img width="1878" height="390" alt="image" src="https://github.com/user-attachments/assets/4fc46500-603c-4a47-854b-4b1150776ca6" />

## Metabase

Перехожу по адресу `http://localhost:3000/setup`

Регистрируюсь. Пароль `testtest1`

<img width="717" height="779" alt="image" src="https://github.com/user-attachments/assets/f4737d72-ae2c-4a8f-9233-610eac7d3acb" />

Сразу подключаю БД

<img width="581" height="877" alt="image" src="https://github.com/user-attachments/assets/d7cec840-84ed-42f7-beb5-b91d2943856e" />

Создаю новый дашборд

<img width="1771" height="708" alt="image" src="https://github.com/user-attachments/assets/fc59e075-9402-4ff4-a2b0-ee679504ea34" />

<img width="554" height="258" alt="image" src="https://github.com/user-attachments/assets/897bc7b4-ee28-499e-8ee5-d455b85ce1e3" />

<img width="403" height="329" alt="image" src="https://github.com/user-attachments/assets/f62eccc0-d3d7-4f94-8566-dfcc77bf9aa4" />

<img width="1012" height="495" alt="image" src="https://github.com/user-attachments/assets/a57fb9bf-72d1-4645-8f7d-b12e0f6ece51" />

<img width="1917" height="569" alt="image" src="https://github.com/user-attachments/assets/0009964b-3f84-4392-b5a3-d864ec0e5d6c" />

<img width="637" height="500" alt="image" src="https://github.com/user-attachments/assets/3769f3af-2862-4624-a8dc-c544bb069af7" />

<img width="1902" height="949" alt="image" src="https://github.com/user-attachments/assets/60f8f545-f012-486e-8819-0db616aa2cbb" />

<img width="1920" height="914" alt="image" src="https://github.com/user-attachments/assets/24863162-0e49-4da0-ac20-e237ad360278" />

<img width="1525" height="732" alt="image" src="https://github.com/user-attachments/assets/d73b1b4b-6853-40b9-a1d4-6a53cbdf3d12" />

<img width="1901" height="518" alt="image" src="https://github.com/user-attachments/assets/25188f50-db81-478b-a3ed-f45a7bd677fc" />

Далее так же нажимаю Новый - Модель - Используйте собственный запрос. И создаю модель на основе таблицы: `dm.fct_count_day_earthquake`.

Дублирую графики и меняю запрос.

<img width="1853" height="727" alt="image" src="https://github.com/user-attachments/assets/2909ca9a-ca7d-4a2d-b5cd-009baa434c24" />

Нажимаю 

<img width="1327" height="394" alt="image" src="https://github.com/user-attachments/assets/06303533-e9a2-4b52-aabf-63489d855598" />

<img width="1894" height="650" alt="image" src="https://github.com/user-attachments/assets/9b92184b-28bd-41df-86f9-aab2558e8c84" />

Сохраняю как новый запрос

<img width="674" height="593" alt="image" src="https://github.com/user-attachments/assets/1c61ce19-3f55-44b3-8836-a29398a7b87c" />

Получаю дашборд

<img width="1875" height="845" alt="image" src="https://github.com/user-attachments/assets/146c49e1-2be6-4c5b-84c5-fdb234590d9c" />


## Итог

Итоговая структура проекта

<img width="678" height="430" alt="image" src="https://github.com/user-attachments/assets/4740b586-53f2-46bf-88d7-a5c09853ba7d" />


## Ошибки

Проблема с `ExternalTaskSensor` при ручном запуске DAG. По расписанию DAG должен запускаться в 05:00 UTC. Соответственно если запускаю в ручную то появляется еще один ручной запуск.

Описание

В DAG используется `ExternalTaskSensor` для ожидания успешного выполнения другого DAG (`raw_from_api_to_s3`). Сохраняю.

При `scheduled run` (scheduled__YYYY-MM-DD...) сенсор отрабатывает корректно.

При `manual run` (manual__YYYY-MM-DD...) сенсор висит в статусе `up_for_reschedule` и никогда не переходит в `success`, хотя целевой DAG уже завершён.

<img width="1873" height="627" alt="image" src="https://github.com/user-attachments/assets/7b79c45d-e41c-4cb2-b4cc-cae330d450d3" />

<img width="1866" height="671" alt="image" src="https://github.com/user-attachments/assets/37eb39b5-d3b9-48e7-9b88-d8eda671cb2c" />

<img width="1882" height="737" alt="image" src="https://github.com/user-attachments/assets/6c0b508e-ad22-413a-b2ca-d727e57d20ae" />

<img width="1892" height="705" alt="image" src="https://github.com/user-attachments/assets/48eab82d-f41d-4df6-8bce-f348123ce297" />

В UI Airflow: Сенсор успешен для `scheduled run`:

```
Run ID: scheduled__2025-11-20T05:00:00+00:00
Status: success
```

Сенсор зависает для `manual run`:

```
Run ID: manual__2025-11-24T12:37:08.894410+00:00
Status: up_for_reschedule
```

Решение:

Сделал не ручной запуск DAG

<img width="1878" height="362" alt="image" src="https://github.com/user-attachments/assets/674160eb-47b4-4ffa-a1a6-49d670630db2" />

А провалился в сам даг в UI Airflow и он запустился от туда.

<img width="1881" height="599" alt="image" src="https://github.com/user-attachments/assets/5481dc96-26e6-4212-90ad-39d1f46eedd3" />

В результате получил 4 запуска как надо. с необходимыми датами. Запуск делал 24.11.2025. Даг собрал данные за 

```
scheduled__2025-11-20T02:00:00+00:00
scheduled__2025-11-21T02:00:00+00:00
scheduled__2025-11-22T02:00:00+00:00
scheduled__2025-11-23T02:00:00+00:00
```
Это пойдет в сенсор.
