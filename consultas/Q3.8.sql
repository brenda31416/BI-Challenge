#¿Cuál es la distribución de clientes por frecuencia de compra? 
WITH cliente_compras AS(	
    SELECT
		customer_name AS cliente,
		COUNT(id_sale) AS compras
		FROM customers c
		LEFT JOIN sales s ON c.id_customer=s.id_customer
		GROUP BY cliente
)    
SELECT
	CASE
		WHEN (compras>=0 AND compras<=5) THEN '0-5'
        WHEN (compras>5 AND compras<=10) THEN '6-10'
        WHEN (compras>10 AND compras<=15) THEN '11-15'
        WHEN (compras>15 AND compras<=20) THEN '16-20'
        ELSE '+20'
	END AS frecuencia_compra,
    COUNT(cliente) AS total_clientes
    FROM cliente_compras
    GROUP BY frecuencia_compra;
    
	