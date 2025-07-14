#¿Cuál es el producto más vendido por país y por mes en el 2023 y 2024?
WITH ventas_agrupadas AS (
	SELECT 
		ct.country AS pais, 
        YEAR(s.date_sale) AS año_venta,
		MONTH(s.date_sale) AS mes_venta,
		p.product_name AS producto,
		SUM(s.quantity) AS unidades_vendidas
	FROM sales s
	LEFT JOIN products p ON s.id_product = p.id_product
	LEFT JOIN customers c ON s.id_customer = c.id_customer
	LEFT JOIN countries ct ON c.id_country = ct.id_country
    WHERE YEAR(s.date_sale)=2023 OR YEAR(s.date_sale)=2024
	GROUP BY 
		ct.country, 
        YEAR(s.date_sale),
		MONTH(s.date_sale),
		p.product_name
),
ventas_ordenadas AS (
	SELECT *, RANK() OVER(PARTITION BY pais, año_venta, mes_venta ORDER BY unidades_vendidas DESC) AS rango
	FROM ventas_agrupadas
)
SELECT 
	pais,
    año_venta,
	mes_venta,
	producto AS producto_mas_vendido,
	unidades_vendidas
FROM ventas_ordenadas
WHERE rango = 1
ORDER BY pais, año_venta DESC, mes_venta DESC;

