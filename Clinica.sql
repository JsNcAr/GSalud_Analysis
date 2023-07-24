CREATE DATABASE pagos DEFAULT CHARACTER SET utf8;
USE pagos;
CREATE TABLE IF NOT EXISTS pagos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    paciente VARCHAR(35) NOT NULL,
    valor INT NOT NULL,
    actividad VARCHAR(35) NOT NULL,
    fecha TIMESTAMP NOT NULL,
    nequi BOOLEAN NOT NULL DEFAULT FALSE,
    datafono BOOLEAN NOT NULL DEFAULT FALSE,
    transferencia BOOLEAN NOT NULL DEFAULT FALSE,
    efectivo BOOLEAN NOT NULL DEFAULT FALSE,
    notas VARCHAR(100) NULL
);

-- Sumar valor de pagos

SELECT SUM(valor) FROM pagos;
INSERT INTO pagos (paciente, valor, actividad, fecha, nequi, datafono, transferencia, efectivo) 
VALUES ('Karol Funeque', 90000, 'Control, Reparaciones', NOW(), FALSE, FALSE, FALSE, TRUE);

-- show table in the day of max value
SELECT * FROM pagos WHERE DATE(fecha) = 
(SELECT DATE(fecha) AS dia FROM pagos GROUP BY dia ORDER BY SUM(valor) DESC LIMIT 1);


-- Get all dates

SELECT DATE(fecha) AS dia FROM pagos GROUP BY dia ORDER BY dia DESC;

-- get sales per day

SELECT DATE(fecha) AS dia, SUM(valor) AS total FROM pagos GROUP BY dia ORDER BY DATE(fecha)

-- get sales per day with day in format month_name day

SELECT DATE_FORMAT(fecha, '%M %d') AS dia, SUM(valor) AS total 
FROM pagos GROUP BY dia, fecha ORDER BY DATE(fecha);

-- get sales per day with day in format weekday month_name day

SELECT DATE_FORMAT(fecha, '%W %M %d') AS dia, SUM(valor) AS total
FROM pagos GROUP BY dia, fecha ORDER BY DATE(fecha);

-- get mean sales per weekdays

SELECT DAYNAME(dia) AS weekday, AVG(sales) AS mean_sales
FROM ( SELECT DATE(fecha) AS dia, SUM(valor) AS sales
       FROM pagos GROUP BY dia, fecha ORDER BY DATE(fecha) ) AS sales
GROUP BY weekday ORDER BY FIELD(weekday, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Get list of activities

SELECT actividad FROM pagos GROUP BY actividad;

-- Get sales per activity

SELECT actividad, SUM(valor) AS total FROM pagos GROUP BY actividad ORDER BY total DESC;

-- get activities where "bichectomia" is in the name

SELECT actividad, valor AS total FROM pagos WHERE actividad LIKE '%lipopapada%' ORDER BY total DESC;

-- divide actvities where "bichectomia" and "lipopapada" are in the name and create one record for each where bichectomia value is equals to 300000 and lipopapada value is equals the original value minus 300000

SELECT paciente, actividad, valor AS total FROM pagos WHERE actividad LIKE '%bichectomia%' OR actividad LIKE '%lipopapada%' ORDER BY total DESC;