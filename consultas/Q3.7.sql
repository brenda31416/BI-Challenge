#¿Cuál es el promedio de cantidad de productos comprados por cliente? 
SELECT 
	ROUND(AVG(cant_productos_comprados),0) AS promedio_compras
FROM(
	SELECT
		c.customer_name AS nombre_cliente,
		SUM(quantity) AS cant_productos_comprados
	FROM customers c
	LEFT JOIN sales s ON c.id_customer=s.id_customer
	GROUP BY c.customer_name
) AS cliente_compras;
