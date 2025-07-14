#¿Cuál es el cliente con más compras durante el último trimestre del año 2023 y 2024? 
WITH cliente_compras AS(
	SELECT
		CONCAT('T',QUARTER(date_sale),'-',YEAR(date_sale)) AS trimestre,
		c.customer_name AS nombre_cliente,
        COUNT(id_sale) AS total_compras
    FROM customers c
    LEFT JOIN sales s ON c.id_customer=s.id_customer
    WHERE quarter(date_sale)=4
    GROUP BY 
		c.customer_name,
        CONCAT('T',QUARTER(date_sale),'-',YEAR(date_sale))
),
max_compras_trim AS(
	SELECT MAX(total_compras) as max_compras
    FROM cliente_compras
    GROUP BY trimestre
)
SELECT 
	trimestre,
    nombre_cliente,
    total_compras
    FROM cliente_compras cm
	JOIN max_compras_trim  mc ON cm.total_compras=mc.max_compras;