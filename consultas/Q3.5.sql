#¿Cuál es el cliente con más compras por país y por mes en el 2023 y 2024? 
WITH cliente_compras AS(
	SELECT 
		ct.country AS pais,
		YEAR(s.date_sale) AS año_compra,
		MONTH(s.date_sale) AS mes_compra,
        	c.customer_name AS cliente,
		COUNT(id_sale) AS total_compras
	FROM sales s
	LEFT JOIN customers c ON s.id_customer=c.id_customer
	LEFT JOIN countries ct ON c.id_country=ct.id_country
	GROUP BY 
		ct.country,
		YEAR(s.date_sale),
		MONTH(s.date_sale),
        	c.customer_name
),
cliente_compras_ordenado AS(
	SELECT *, RANK() OVER(PARTITION BY pais, año_compra, mes_compra ORDER BY total_compras DESC) AS rango
    	FROM cliente_compras
)
SELECT 
	pais,
	año_compra,
    	mes_compra,
    	cliente,
    	total_compras
FROM cliente_compras_ordenado
WHERE rango=1
ORDER BY 
	pais, 
    	año_compra DESC,
    	mes_compra DESC;
	
