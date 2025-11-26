CREATE SCHEMA stg;
CREATE SCHEMA ods;
CREATE SCHEMA dm;


DROP TABLE IF EXISTS ods.fct_earthquake

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


/* Проверки */
SELECT *
FROM ods.fct_earthquake

SELECT distinct CAST(time AS DATE) AS date_time
FROM ods.fct_earthquake

SELECT count(*)
FROM ods.fct_earthquake




CREATE TABLE dm.fct_count_day_earthquake AS 
SELECT time::date AS date, count(*)
FROM ods.fct_earthquake
WHERE time::date = '2025-11-20'
GROUP BY 1


CREATE TABLE dm.fct_avg_day_earthquake AS
SELECT time::date AS date, avg(mag::float)
FROM ods.fct_earthquake
WHERE time::date = '2025-11-20'
GROUP BY 1 