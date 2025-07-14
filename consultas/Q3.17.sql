#¿Cuántos productos no han tenido ventas durante el último trimestre del año 2023 y 2024? 
SELECT
	COUNT(*) AS cant_productos_sin_ventas
FROM(
	SELECT 
			CONCAT('Q',QUARTER(date_sale),'-',YEAR(date_sale)) AS trimestre,
			product_name AS producto,
			COUNT(id_sale) AS ventas
		FROM products p
		LEFT JOIN sales s ON p.id_product=s.id_product
		GROUP BY 
			trimestre,
			producto
		HAVING trimestre IN ('Q4-2023','2024') OR trimestre IS NULL
) AS producto_ventas
WHERE ventas=0;

#¿Cuántos clientes no han tenido compras durante el último trimestre del año 2023 y 2024? 
SELECT
	COUNT(*) AS cant_clientes_sin_compras
FROM(
	SELECT 
			CONCAT('Q',QUARTER(date_sale),'-',YEAR(date_sale)) AS trimestre,
			customer_name AS cliente,
			COUNT(id_sale) AS compras
		FROM customers c
		LEFT JOIN sales s ON c.id_customer=s.id_customer
        GROUP BY 
			trimestre,
			cliente
		HAVING trimestre IN ('Q4-2023','2024') OR trimestre IS NULL
) AS cliente_compras
WHERE compras=0;