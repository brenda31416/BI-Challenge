#¿Qué regiones tienen el mayor ratio de cancelaciones? 
WITH  region_status_venta AS(
	SELECT
		continent AS region,
        	os.description AS estatus_venta,
        COUNT(id_sale) AS ventas
    	FROM regions r
    	LEFT JOIN customers c ON r.id_region=c.id_region
    	LEFT JOIN sales s ON c.id_customer=s.id_customer
    	LEFT JOIN order_status os ON s.id_status=os.id_status
    	GROUP BY 
		continent,
        	os.description
),
region_ventas AS(
	SELECT 
		continent AS region,
		COUNT(id_sale) AS total_ventas
   	 FROM regions r
    	LEFT JOIN customers c ON r.id_region=c.id_region
    	LEFT JOIN sales s ON c.id_customer=s.id_customer
    	LEFT JOIN order_status os ON s.id_status=os.id_status
   	GROUP BY continent
)
SELECT
	rsv.region,
    	CONCAT(ROUND((rsv.ventas/rv.total_ventas)*100,0),'%') AS ratio_cancelaciones
FROM region_status_venta rsv
LEFT JOIN region_ventas rv ON rsv.region=rv.region
WHERE estatus_venta='Cancelled'
GROUP BY rsv.region
ORDER BY ratio_cancelaciones DESC
LIMIT 2;
