# ¿Cuál es la tasa de devolución/cancelación por producto? 
WITH producto_ventastotal AS(
	SELECT 
		product_name AS producto, 
		COUNT(id_sale) AS total_ventas
	FROM products p 
	LEFT JOIN  sales s ON p.id_product=s.id_product
	LEFT JOIN order_status os ON s.id_status=os.id_status
	GROUP BY producto
),
producto_ventastatus AS (
	SELECT
		product_name AS producto,
        COUNT(CASE WHEN os.description = 'Returned' THEN 1 END) AS ventas_devueltas,
        COUNT(CASE WHEN os.description = 'Cancelled' THEN 1 END) AS ventas_canceladas 
	FROM products p 
	LEFT JOIN sales s ON p.id_product=s.id_product
	LEFT JOIN order_status os ON s.id_status=os.id_status
	GROUP BY producto
)
SELECT 
	pvt.producto,
	CASE WHEN pvt.total_ventas!=0 THEN CONCAT(ROUND(pvs.ventas_devueltas*100/pvt.total_ventas,0),'%') ELSE 0 END AS tasa_devolucion,
    CASE WHEN pvt.total_ventas!=0 THEN CONCAT(ROUND(pvs.ventas_canceladas*100/pvt.total_ventas,0),'%') ELSE 0 END AS tasa_cancelacion
FROM producto_ventastotal pvt  
LEFT JOIN producto_ventastatus pvs ON pvt.producto=pvs.producto
GROUP BY pvt.producto
ORDER BY pvt.producto;