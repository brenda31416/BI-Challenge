#¿Cuál es la distribución geográfica de las ventas de productos Nike durante el Q3-2023 y  Q1-2024? 
SELECT
	CONCAT('Q',QUARTER(date_sale),'-',YEAR(date_sale)) AS trimestre,
	country AS pais,
    	COUNT(id_sale) AS total_ventas
    	FROM countries ct
LEFT JOIN customers c ON ct.id_country=c.id_country
LEFT JOIN sales s ON c.id_customer=s.id_customer
GROUP BY 
	ct.country, 
        CONCAT('Q',QUARTER(date_sale),'-',YEAR(date_sale))
	HAVING trimestre='Q3-2023' OR trimestre='Q1-2024'
ORDER BY trimestre, pais;
