#¿Cuál es el promedio de ventas por región o país durante el último trimestre del año 2023 y 2024? 
SELECT trimestre, ROUND(SUM(ventas)/5,0) AS promedio_ventas_region
FROM ( 
    SELECT 
		CONCAT('Q', QUARTER(date_sale),'-',YEAR(date_sale)) AS trimestre,
		continent AS region,
		COUNT(id_sale) AS ventas
	FROM regions r
	LEFT JOIN customers c ON r.id_region=c.id_region
	LEFT JOIN sales s ON c.id_customer=s.id_customer
	WHERE QUARTER(date_sale)=4
	GROUP BY 
		region, 
		CONCAT('Q', QUARTER(date_sale),'-',YEAR(date_sale))
) AS region_ventastrim
GROUP BY trimestre