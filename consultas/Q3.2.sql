#¿Cuál es el producto más vendido durante el último trimestre del año 2023 y 2024? 
WITH ventas_agrupadas AS(
	SELECT
		CONCAT('T', QUARTER(date_sale),'-', YEAR(date_sale)) AS trimestre_año,
		p.product_name AS producto,
        	SUM(quantity) AS unidades_vendidas
	FROM sales s
	LEFT JOIN products p ON s.id_product=p.id_product
    	WHERE QUARTER(date_sale)=4
   	GROUP BY 
		CONCAT('T', QUARTER(date_sale),'-', YEAR(date_sale)),
        	p.product_name
),
ventas_ordenadas AS (
	SELECT *, RANK() OVER(PARTITION BY trimestre_año ORDER BY unidades_vendidas DESC) AS rango
    	FROM ventas_agrupadas
)
SELECT 
	trimestre_año,
	producto,
	unidades_vendidas
FROM ventas_ordenadas
WHERE rango=1
ORDER BY trimestre_año, producto;
