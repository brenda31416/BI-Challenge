#¿Qué porcentaje de las ventas se ve afectado por aquellas órdenes devueltas y canceladas? 
SELECT 
	CONCAT(ROUND(COUNT(CASE WHEN estado='Cancelled' THEN 1 END)*100/COUNT(id_sale),0),'%') AS tasa_cancelaciones,
    CONCAT(ROUND(COUNT(CASE WHEN estado='Returned' THEN 1 END)*100/COUNT(id_sale),0),'%') AS tasa_devoluciones
FROM (
	SELECT 
		id_sale,
		os.description AS estado
	FROM sales s
	LEFT JOIN order_status os ON s.id_status=os.id_status
) AS venta_estado