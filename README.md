# Pet Project — Earthquake Data Pipeline

Полный ETL-пайплайн для сбора, хранения, обработки и визуализации данных о землетрясениях

## Цель проекта

Создать систему, которая автоматически получает данные о землетрясениях из открытого API, сохраняет их в объектное хранилище S3 (MinIO), обрабатывает с помощью Apache Airflow, загружает очищенные данные в PostgreSQL и визуализирует результаты через Metabase.

Проект полностью контейнеризован с помощью Docker и демонстрирует ключевые практики дата-инженерии:

— работа с объектным хранилищем,

— организация DAG'ов,

— разделение слоёв данных (raw / transformed / analytics),

— автоматизация ETL-процессов,

— построение витрин данных,

— использование Git для управления версионностью и структуры проекта.

## Ссылки

- [Описание работы API](https://earthquake.usgs.gov/fdsnws/event/1/#methods)
  
- [Описание полей из API](https://earthquake.usgs.gov/data/comcat/index.php)
  
- [Настройка и последовательность шагов](https://github.com/erohin94/pet_project_earthquake/blob/main/step.md)

## Data Governance

Data Governance - принципы по которым надо создавать Data продукт. Принцип на который стоит опираться.

<img width="823" height="675" alt="image" src="https://github.com/user-attachments/assets/d84d0654-c583-4f83-9e84-9916a5a41142" />

### 1. Data Architecture

Lakehouse

<img width="1500" height="564" alt="image" src="https://github.com/user-attachments/assets/66dae9a8-a252-493f-921c-b0e58d6afe6d" />

### 2. Data Modeling & Design

Не применяется звезда, снежинка или другое, потому что в этом нет необходимости. Данных немного. Состояние измениться не может, поэтому создаём модель по типу "AS IS".

### 3. Data Storage & Operations

**Storage**

Cold, Warm Storage – S3 (Данные за все время, дешевое хранение, доступ не быстрый)

Hot Storage – PostgreSQL (Для того чтобы данные работали быстрее, переносим в постгре. Храним актуальное, то что нужно сейчас)

**Compute/Operations**

DuckDB – Data Lake 

PostgreSQL – DM layer

### 4. Data Security

Безопасность настраивается на уровне пользователей в S3 и ролевой модели в PostgreSQL. В Airflow задаётся безопасность через роли.

Здесь может быть использован LDAP

### 5. Data Integration & Interoperability (Интеграция данных и совместимость)

В данном случае не занимаюсь этим пунктом, потому что для демонстрации и текущей реализации достаточно, но для "правильной" работы необходимо ods слой "приводить" к нужным типам.

К примеру, сейчас:

```
time varchar
```

А нужно:

```
time timestamp
```

### 6. Documents & Content

Документация в виде видео, дополнительно могут быть комментарии, описание на внутренних ресурсах и прочее

### 7. Reference & Master Data

В данном случае у нас данные, которые находятся в Data Lake S3, являются "золотыми". Мы их взяли из источника "как есть" и не модифицируем, тем самым вероятность их потерять в нашем пайплайне равно 0%. Но это не говорит, что изменение данных невозможно/запрещено. Разрешено в других "слоях", на уровне dwh или в своих реализациях.

### 8. Data Warehousing & Business Intelligence

Как было сказано выше "горячее" хранение у нас в PostgreSQL.

Для BI-системы мы используем Metabase.

Из общих рекомендаций по данному пункту:

 1) Задавать "жизнь" для витрин. Потому что сейчас бизнесу нужна витрина N, а через месяц нет. И чтобы она не крутилась просто так необходимо проводить "уборки".

 2) Определить роли для отчётов и допустимых зон. К примеру C-уровень должен видеть Все отчёты. А уровень курьеров не должен видеть витрины по опционам и выручке компании

 3) Сформировать правила формирования витрин
    
    - Один показатель – одна витрина
     
    - Один показатель – одна вью/мат.вью
    
    - Широкая витрина
      
    - Одна таблица, которая содержит все показатели и её вид примерно такой: дата-день, тип показателя, значение

 5) Мониторинг активности и нагрузка

 6) Автоматическое обновление. Исключить "ручной" труд

### 9. Meta-data

Сейчас мета-данных нет, но их можно задать к примеру через комментарии к столбцам в DWH.

Вот к примеру описание всех колонок – [Описание полей из API](https://earthquake.usgs.gov/data/comcat/index.php)

Для уровня Data Lake явно должны быть свои инструменты для формирования мета-данных.

Тут необходимо искать удобный для вашей команды дата-каталог: OpenMetaData, DataHub и прочее.

### 10. Data Quality

Дата кволити сейчас нет. Потому что опять же долго реализуется и это большая тема.

Но из основного:

- Нужно смотреть "долетели" ли данные (ACID).

- Смотреть SLA доставки данных

- Определить важные дашборды. И повешать разные алерты на них.

- Стараться при возможности смотреть на "источник". Условно Если у на источнике 1000 строк, а у нас в Data Lake/DWH 999 строк мы должны узнать об этом сразу, а не через месяц.

- Нужен процесс, который позволит исправлять такие ошибки

- Если витрина Очень важная, то проводить свои тесты перед попаданием их на прод. Смотреть на дельту между значениями, смотреть на среднее значение и прочее. Критерии "качества" необходимо выяснять у бизнеса.

## Notes

SQL схемы:

```
CREATE SCHEMA ods;
CREATE SCHEMA dm;
CREATE SCHEMA stg;
```

DDL ods.fct_earthquake:

```
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

DDL dm.fct_count_day_earthquake:

```
CREATE TABLE dm.fct_count_day_earthquake AS 
SELECT time::date AS date, count(*)
FROM ods.fct_earthquake
GROUP BY 1
```

DDL dm.fct_avg_day_earthquake:

```
CREATE TABLE dm.fct_avg_day_earthquake AS
SELECT time::date AS date, avg(mag::float)
FROM ods.fct_earthquake
GROUP BY 1
```
