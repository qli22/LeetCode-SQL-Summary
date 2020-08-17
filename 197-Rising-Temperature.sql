'''
197. Rising Temperature (Easy)

Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
This table contains information about the temperature in a certain day.


Write an SQL query to find all dates id with higher temperature compared to its previous dates (yesterday).

Return the result table in any order.

The query result format is in the following example:

Weather
+----+------------+-------------+
| id | recordDate | Temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+

Result table:
+----+
| id |
+----+
| 2  |
| 4  |
+----+
In 2015-01-02, temperature was higher than the previous day (10 -> 25).
In 2015-01-04, temperature was higher than the previous day (30 -> 20).
'''


-- Answer (T-SQL):

-- 1. Temp table
With temp AS (
  SELECT *,
  LAG(Temperature) OVER (ORDER BY recordDate) AS pre_temp,
  LAG(recordDate) OVER (ORDER BY recordDate) AS pre_date
  FROM weather
) t

SELECT id FROM t
WHERE DATEADD(day,1,prev_date) = recordDate AND prev_temp < Temperature;

-- 2. join
SELECT t1.id
FROM weather t1
JOIN weather t2 ON DATEADD(day, 1, t1.recordDate) = t2.recordDate
WHERE t2.Temperature < t1.Temperature;
